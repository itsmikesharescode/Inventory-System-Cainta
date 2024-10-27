create or replace function add_returnee(
    teacher_real_id_input text,
    reference_id_input text,
    borrower_name_input text,
    borrowed_date_input date,
    returned_date_input date,
    items_returned_input jsonb
) returns void as $$
begin
    if exists (select 1 from teachers_tb t where t.teacher_real_id = teacher_real_id_input) then
        -- Insert returnee into the returned_items_tb
        insert into returned_items_tb (teacher_real_id, reference_id, borrower_name, borrowed_date, returned_date, returned_items)
        values (teacher_real_id_input, reference_id_input, borrower_name_input, borrowed_date_input, returned_date_input, items_returned_input);
    else
        raise exception 'Teacher ID % not found in database.', input_teacher_id;
    end if;
end;
$$ language plpgsql;