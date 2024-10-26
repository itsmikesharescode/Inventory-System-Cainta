create or replace function admin_dashboard_counts() returns jsonb as $$
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
$$ language plpgsql;