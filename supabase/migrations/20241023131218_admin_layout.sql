create or replace function admin_layout_load()
returns jsonb as $$
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
$$ language plpgsql set search_path = '';
