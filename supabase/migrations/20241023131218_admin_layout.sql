create or replace function admin_layout_load()
returns jsonb as $$
declare
  item_data jsonb;
  teacher_data jsonb;
begin

  select json_agg(row_to_json(itd)) into item_data
  from (select * from public.items_tb order by created_at asc ) as itd;

  select json_agg(row_to_json(ttd)) into teacher_data
  from (select * from public.teachers_tb order by created_at asc ) as ttd;

  return jsonb_build_object(
    'items', coalesce(item_data, '[]'::jsonb),
    'teachers', coalesce(teacher_data, '[]'::jsonb)
  );
end;
$$ language plpgsql set search_path = '';
