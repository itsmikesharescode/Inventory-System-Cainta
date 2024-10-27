create or replace function add_borrower(
    client_input jsonb
) returns void as $$
declare
    teacher_id text;
    borrower_name text;
    borrowed_date date;
    room text;
begin
    -- Extract values from the JSON input
    teacher_id := client_input->>'teacherId';
    borrower_name := client_input->>'borrowerName';
    borrowed_date := (client_input->>'borrowedDate')::date;
    room := client_input->>'room';

    -- Check if the teacherId exists in the teachers_tb
    if exists (select 1 from teachers_tb where teacher_id_real = teacher_id) then
        -- Insert borrower information into the borrowers table
        insert into borrowers (teacher_id, borrower_name, borrowed_date, room)
        values (teacher_id, borrower_name, borrowed_date, room);

        -- You can add more logic here to handle itemsBorrowed if needed
    else
        raise exception 'Teacher ID % not found in teachers_tb', teacher_id;
    end if;
end;
$$ language plpgsql;