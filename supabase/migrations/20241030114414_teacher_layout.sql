create or replace function teacher_layout_load()
returns jsonb as $$
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
$$ language plpgsql set search_path = '';