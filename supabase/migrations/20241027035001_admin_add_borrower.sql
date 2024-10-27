create or replace function add_borrower(
    client_input jsonb
) returns void as $$
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
$$ language plpgsql;