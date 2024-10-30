

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."add_borrower"("client_input" "jsonb") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
declare
    input_teacher_id text;
    borrower_name text;
    borrowed_date date;
    room text;
    items_borrowed jsonb;
    gen_reference_id text;
begin
    -- Extract values from the JSON input
    input_teacher_id := client_input->>'teacherId';
    borrower_name := client_input->>'borrowerName';
    borrowed_date := (client_input->>'borrowedDate')::date;
    room := client_input->>'room';
    items_borrowed := client_input->'itemsBorrowed';

    gen_reference_id := substring(gen_random_uuid()::text from 1 for 8);

    -- Check if the teacherId exists in the teachers_tb
    if exists (select 1 from teachers_tb t where t.teacher_real_id = input_teacher_id) then

        -- Insert items borrowed into the borrowed_items_tb
        insert into borrowed_items_tb (teacher_real_id, reference_id, borrower_name, borrowed_date, room, items_borrowed)
        values (input_teacher_id, gen_reference_id, borrower_name, borrowed_date, room, items_borrowed);

    else
        raise exception 'Teacher ID % not found in database.', input_teacher_id;
    end if;
end;
$$;


ALTER FUNCTION "public"."add_borrower"("client_input" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."add_reservation"("teacher_real_id_input" "text", "teacher_name_input" "text", "max_items_input" numeric, "room_input" "text", "time_limit_input" "text") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
declare
    gen_reference_id text;
begin
    gen_reference_id := substring(gen_random_uuid()::text from 1 for 8);

    if exists (select 1 from teachers_tb t where t.teacher_real_id = teacher_real_id_input) then
        insert into reservations_tb (teacher_real_id, max_items, room, time_limit, status, teacher_name, reference_id)
        values (teacher_real_id_input, max_items_input, room_input, time_limit_input, 'Pending', teacher_name_input, gen_reference_id);
    else
        raise exception 'Teacher ID % not found in database.', teacher_real_id_input;
    end if;
end;
$$;


ALTER FUNCTION "public"."add_reservation"("teacher_real_id_input" "text", "teacher_name_input" "text", "max_items_input" numeric, "room_input" "text", "time_limit_input" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."add_returnee"("teacher_real_id_input" "text", "reference_id_input" "text", "borrower_name_input" "text", "borrowed_date_input" "date", "returned_date_input" "date", "items_returned_input" "jsonb") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
begin
    if exists (select 1 from teachers_tb t where t.teacher_real_id = teacher_real_id_input) then
        -- Insert returnee into the returned_items_tb
        insert into returned_items_tb (teacher_real_id, reference_id, borrower_name, borrowed_date, returned_date, returned_items)
        values (teacher_real_id_input, reference_id_input, borrower_name_input, borrowed_date_input, returned_date_input, items_returned_input);
    else
        raise exception 'Teacher ID % not found in database.', input_teacher_id;
    end if;
end;
$$;


ALTER FUNCTION "public"."add_returnee"("teacher_real_id_input" "text", "reference_id_input" "text", "borrower_name_input" "text", "borrowed_date_input" "date", "returned_date_input" "date", "items_returned_input" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."admin_dashboard_counts"() RETURNS "jsonb"
    LANGUAGE "plpgsql"
    AS $$
declare
    pending_count integer;
    accepted_count integer;
    canceled_count integer;
    teacher_count integer;
begin
    select count(*) into pending_count
    from public.reservations_tb
    where status = 'Pending';

    select count(*) into accepted_count
    from public.reservations_tb
    where status = 'Accepted';

    select count(*) into canceled_count
    from public.reservations_tb
    where status = 'Canceled';

    select count(*) into teacher_count
    from teachers_tb;

    return jsonb_build_object(
        'pending_count', coalesce(pending_count, 0),
        'accepted_count', coalesce(accepted_count, 0),
        'canceled_count', coalesce(canceled_count, 0),
        'teachers_count', coalesce(teacher_count, 0)
    );
end;
$$;


ALTER FUNCTION "public"."admin_dashboard_counts"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."admin_layout_load"() RETURNS "jsonb"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
declare
  item_data jsonb;
  teacher_data jsonb;
  reservation_data jsonb;
  borrowed_data jsonb;
  returned_data jsonb;
begin

  select json_agg(row_to_json(itd)) into item_data
  from (select * from public.items_tb order by created_at asc ) as itd;

  select json_agg(row_to_json(ttd)) into teacher_data
  from (select * from public.teachers_tb order by created_at asc ) as ttd;

  select json_agg(row_to_json(rtd)) into reservation_data
  from (select * from public.reservations_tb order by created_at asc) as rtd;

  select json_agg(row_to_json(btd)) into borrowed_data
  from (select * from public.borrowed_items_tb order by created_at asc) as btd;

  select json_agg(row_to_json(rtd)) into returned_data
  from (select * from public.returned_items_tb order by created_at asc) as rtd;

  return jsonb_build_object(
    'items', coalesce(item_data, '[]'::jsonb),
    'teachers', coalesce(teacher_data, '[]'::jsonb),
    'reservations', coalesce(reservation_data, '[]'::jsonb),
    'borrowed_items', coalesce(borrowed_data, '[]'::jsonb),
    'returned_items', coalesce(returned_data, '[]'::jsonb)
  );
end;
$$;


ALTER FUNCTION "public"."admin_layout_load"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin"() RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin
  return exists(
    select 1 
    from role_tb 
    where user_id = auth.uid() 
      and role = 'admin'
  );
end;
$$;


ALTER FUNCTION "public"."is_admin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_teacher"() RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin
  return exists(
    select 1 
    from role_tb 
    where user_id = auth.uid() 
      and role = 'teacher'
  );
end;
$$;


ALTER FUNCTION "public"."is_teacher"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."on_auth_user_created"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
declare
  role text;
begin
  role = new.raw_user_meta_data ->> 'role'; 

  insert into public.teachers_tb (teacher_id, teacher_real_id, user_meta_data)
  values (
    new.id,
    new.raw_user_meta_data ->> 'teacher_real_id',
    new.raw_user_meta_data
  );
  insert into public.role_tb (user_id, role) values(new.id, role);
  return new;

end;
$$;


ALTER FUNCTION "public"."on_auth_user_created"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."on_auth_user_updated"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
begin

  update public.teachers_tb
  set user_meta_data = new.raw_user_meta_data
  where teacher_id = new.id;
  return new;

end;
$$;


ALTER FUNCTION "public"."on_auth_user_updated"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."teacher_layout_load"() RETURNS "jsonb"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
declare
  reservation_data jsonb;
begin
  select json_agg(row_to_json(rtd))::jsonb into reservation_data
  from (
    select * 
    from public.reservations_tb 
    where teacher_real_id = (auth.jwt() -> 'user_metadata'::text ->> 'teacher_real_id'::text)
    order by created_at asc
  ) as rtd;

  return jsonb_build_object(
    'reservations', coalesce(reservation_data, '[]'::jsonb)
  );
end;
$$;


ALTER FUNCTION "public"."teacher_layout_load"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."borrowed_items_tb" (
    "id" bigint NOT NULL,
    "reference_id" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "teacher_real_id" "text" NOT NULL,
    "borrower_name" "text" NOT NULL,
    "borrowed_date" "date" NOT NULL,
    "room" character varying NOT NULL,
    "items_borrowed" "jsonb" NOT NULL
);


ALTER TABLE "public"."borrowed_items_tb" OWNER TO "postgres";


COMMENT ON TABLE "public"."borrowed_items_tb" IS 'list of borrowed item';



ALTER TABLE "public"."borrowed_items_tb" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."borrowed_items_tb_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."items_tb" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "admin_id" "uuid" NOT NULL,
    "device_id" "text" NOT NULL,
    "model" "text" NOT NULL,
    "category" "text" NOT NULL,
    "type" "text" NOT NULL,
    "status" "text" NOT NULL,
    "mr" "text" NOT NULL,
    "brand" "text" NOT NULL,
    "quantity" numeric NOT NULL,
    "price" numeric NOT NULL,
    "description" "text" NOT NULL
);


ALTER TABLE "public"."items_tb" OWNER TO "postgres";


COMMENT ON TABLE "public"."items_tb" IS 'list of items';



ALTER TABLE "public"."items_tb" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."items_tb_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."reservations_tb" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "reference_id" "text" NOT NULL,
    "teacher_real_id" "text" NOT NULL,
    "max_items" numeric NOT NULL,
    "room" character varying NOT NULL,
    "time_limit" character varying NOT NULL,
    "status" character varying NOT NULL,
    "teacher_name" "text" NOT NULL
);


ALTER TABLE "public"."reservations_tb" OWNER TO "postgres";


COMMENT ON TABLE "public"."reservations_tb" IS 'list of reservations';



ALTER TABLE "public"."reservations_tb" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."reservations_tb_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."returned_items_tb" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "reference_id" "text" NOT NULL,
    "teacher_real_id" "text" NOT NULL,
    "borrower_name" "text" NOT NULL,
    "borrowed_date" "date" NOT NULL,
    "returned_date" "date" NOT NULL,
    "returned_items" "jsonb" NOT NULL
);


ALTER TABLE "public"."returned_items_tb" OWNER TO "postgres";


COMMENT ON TABLE "public"."returned_items_tb" IS 'list of returned items';



ALTER TABLE "public"."returned_items_tb" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."returned_items_tb_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."role_tb" (
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "role" character varying NOT NULL
);


ALTER TABLE "public"."role_tb" OWNER TO "postgres";


COMMENT ON TABLE "public"."role_tb" IS 'list of roles';



CREATE TABLE IF NOT EXISTS "public"."teachers_tb" (
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "teacher_id" "uuid" NOT NULL,
    "user_meta_data" "jsonb" NOT NULL,
    "teacher_real_id" "text" NOT NULL
);


ALTER TABLE "public"."teachers_tb" OWNER TO "postgres";


COMMENT ON TABLE "public"."teachers_tb" IS 'list of created teachers';



ALTER TABLE ONLY "public"."borrowed_items_tb"
    ADD CONSTRAINT "borrowed_items_tb_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."borrowed_items_tb"
    ADD CONSTRAINT "borrowed_items_tb_reference_id_key" UNIQUE ("reference_id");



ALTER TABLE ONLY "public"."items_tb"
    ADD CONSTRAINT "items_tb_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reservations_tb"
    ADD CONSTRAINT "reservations_tb_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."reservations_tb"
    ADD CONSTRAINT "reservations_tb_reference_id_key" UNIQUE ("reference_id");



ALTER TABLE ONLY "public"."returned_items_tb"
    ADD CONSTRAINT "returned_items_tb_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."returned_items_tb"
    ADD CONSTRAINT "returned_items_tb_reference_id_key" UNIQUE ("reference_id");



ALTER TABLE ONLY "public"."role_tb"
    ADD CONSTRAINT "role_tb_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."teachers_tb"
    ADD CONSTRAINT "teachers_tb_pkey" PRIMARY KEY ("teacher_id");



ALTER TABLE ONLY "public"."teachers_tb"
    ADD CONSTRAINT "teachers_tb_teacher_real_id_key" UNIQUE ("teacher_real_id");



ALTER TABLE ONLY "public"."borrowed_items_tb"
    ADD CONSTRAINT "borrowed_items_tb_teacher_real_id_fkey" FOREIGN KEY ("teacher_real_id") REFERENCES "public"."teachers_tb"("teacher_real_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."items_tb"
    ADD CONSTRAINT "items_tb_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reservations_tb"
    ADD CONSTRAINT "reservations_tb_teacher_real_id_fkey" FOREIGN KEY ("teacher_real_id") REFERENCES "public"."teachers_tb"("teacher_real_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."returned_items_tb"
    ADD CONSTRAINT "returned_items_tb_teacher_real_id_fkey" FOREIGN KEY ("teacher_real_id") REFERENCES "public"."teachers_tb"("teacher_real_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."role_tb"
    ADD CONSTRAINT "role_tb_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."teachers_tb"
    ADD CONSTRAINT "teacher_list_tb_teacher_id_fkey" FOREIGN KEY ("teacher_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



CREATE POLICY "Allow all if admin" ON "public"."borrowed_items_tb" TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



CREATE POLICY "Allow all if admin" ON "public"."reservations_tb" TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



CREATE POLICY "Allow all if admin" ON "public"."returned_items_tb" TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



CREATE POLICY "Allow all if admin" ON "public"."teachers_tb" TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



CREATE POLICY "Allow delete if teacher" ON "public"."reservations_tb" FOR DELETE TO "authenticated" USING (("public"."is_teacher"() AND (((("auth"."jwt"() ->> 'user_metadata'::"text"))::"jsonb" ->> 'teacher_real_id'::"text") = "teacher_real_id")));



CREATE POLICY "Allow insert if teacher" ON "public"."reservations_tb" FOR INSERT TO "authenticated" WITH CHECK ("public"."is_teacher"());



CREATE POLICY "Allow select if teacher" ON "public"."reservations_tb" FOR SELECT TO "authenticated" USING (("public"."is_teacher"() AND (((("auth"."jwt"() ->> 'user_metadata'::"text"))::"jsonb" ->> 'teacher_real_id'::"text") = "teacher_real_id")));



CREATE POLICY "Allow select if teacher and exist" ON "public"."borrowed_items_tb" FOR SELECT TO "authenticated" USING (("public"."is_teacher"() AND (((("auth"."jwt"() ->> 'user_metadata'::"text"))::"jsonb" ->> 'teacher_real_id'::"text") = "teacher_real_id")));



CREATE POLICY "Allow select if teacher and exist" ON "public"."returned_items_tb" FOR SELECT TO "authenticated" USING (("public"."is_teacher"() AND (((("auth"."jwt"() ->> 'user_metadata'::"text"))::"jsonb" ->> 'teacher_real_id'::"text") = "teacher_real_id")));



CREATE POLICY "Allow select if teacher and exist" ON "public"."teachers_tb" FOR SELECT TO "authenticated" USING (("public"."is_teacher"() AND (((("auth"."jwt"() ->> 'user_metadata'::"text"))::"jsonb" ->> 'teacher_real_id'::"text") = "teacher_real_id")));



CREATE POLICY "allow all if admin" ON "public"."items_tb" TO "authenticated" USING ("public"."is_admin"()) WITH CHECK ("public"."is_admin"());



ALTER TABLE "public"."borrowed_items_tb" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."items_tb" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."reservations_tb" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."returned_items_tb" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."role_tb" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."teachers_tb" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";





GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






































































































































































































GRANT ALL ON FUNCTION "public"."add_borrower"("client_input" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."add_borrower"("client_input" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_borrower"("client_input" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."add_reservation"("teacher_real_id_input" "text", "teacher_name_input" "text", "max_items_input" numeric, "room_input" "text", "time_limit_input" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."add_reservation"("teacher_real_id_input" "text", "teacher_name_input" "text", "max_items_input" numeric, "room_input" "text", "time_limit_input" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_reservation"("teacher_real_id_input" "text", "teacher_name_input" "text", "max_items_input" numeric, "room_input" "text", "time_limit_input" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."add_returnee"("teacher_real_id_input" "text", "reference_id_input" "text", "borrower_name_input" "text", "borrowed_date_input" "date", "returned_date_input" "date", "items_returned_input" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."add_returnee"("teacher_real_id_input" "text", "reference_id_input" "text", "borrower_name_input" "text", "borrowed_date_input" "date", "returned_date_input" "date", "items_returned_input" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."add_returnee"("teacher_real_id_input" "text", "reference_id_input" "text", "borrower_name_input" "text", "borrowed_date_input" "date", "returned_date_input" "date", "items_returned_input" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."admin_dashboard_counts"() TO "anon";
GRANT ALL ON FUNCTION "public"."admin_dashboard_counts"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."admin_dashboard_counts"() TO "service_role";



GRANT ALL ON FUNCTION "public"."admin_layout_load"() TO "anon";
GRANT ALL ON FUNCTION "public"."admin_layout_load"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."admin_layout_load"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_teacher"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_teacher"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_teacher"() TO "service_role";



GRANT ALL ON FUNCTION "public"."on_auth_user_created"() TO "anon";
GRANT ALL ON FUNCTION "public"."on_auth_user_created"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."on_auth_user_created"() TO "service_role";



GRANT ALL ON FUNCTION "public"."on_auth_user_updated"() TO "anon";
GRANT ALL ON FUNCTION "public"."on_auth_user_updated"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."on_auth_user_updated"() TO "service_role";



GRANT ALL ON FUNCTION "public"."teacher_layout_load"() TO "anon";
GRANT ALL ON FUNCTION "public"."teacher_layout_load"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."teacher_layout_load"() TO "service_role";





















GRANT ALL ON TABLE "public"."borrowed_items_tb" TO "anon";
GRANT ALL ON TABLE "public"."borrowed_items_tb" TO "authenticated";
GRANT ALL ON TABLE "public"."borrowed_items_tb" TO "service_role";



GRANT ALL ON SEQUENCE "public"."borrowed_items_tb_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."borrowed_items_tb_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."borrowed_items_tb_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."items_tb" TO "anon";
GRANT ALL ON TABLE "public"."items_tb" TO "authenticated";
GRANT ALL ON TABLE "public"."items_tb" TO "service_role";



GRANT ALL ON SEQUENCE "public"."items_tb_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."items_tb_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."items_tb_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."reservations_tb" TO "anon";
GRANT ALL ON TABLE "public"."reservations_tb" TO "authenticated";
GRANT ALL ON TABLE "public"."reservations_tb" TO "service_role";



GRANT ALL ON SEQUENCE "public"."reservations_tb_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."reservations_tb_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."reservations_tb_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."returned_items_tb" TO "anon";
GRANT ALL ON TABLE "public"."returned_items_tb" TO "authenticated";
GRANT ALL ON TABLE "public"."returned_items_tb" TO "service_role";



GRANT ALL ON SEQUENCE "public"."returned_items_tb_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."returned_items_tb_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."returned_items_tb_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."role_tb" TO "anon";
GRANT ALL ON TABLE "public"."role_tb" TO "authenticated";
GRANT ALL ON TABLE "public"."role_tb" TO "service_role";



GRANT ALL ON TABLE "public"."teachers_tb" TO "anon";
GRANT ALL ON TABLE "public"."teachers_tb" TO "authenticated";
GRANT ALL ON TABLE "public"."teachers_tb" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
