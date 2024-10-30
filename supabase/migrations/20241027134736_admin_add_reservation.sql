create or replace function add_reservation(
    teacher_real_id_input text,
    teacher_name_input text,
    max_items_input numeric,
    room_input text,
    time_limit_input text
) returns void as $$
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
$$ language plpgsql;