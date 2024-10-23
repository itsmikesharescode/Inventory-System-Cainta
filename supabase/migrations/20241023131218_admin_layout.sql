create or replace function admin_layout_load()
returns jsonb as $$
declare
  evaluation_list_tb_data jsonb;
begin


  -- Aggregate evaluation_list_tb_data into JSONB
  select json_agg(row_to_json(eltd)) into evaluation_list_tb_data
  from (select * from public.evaluation_list_tb order by created_at asc) as eltd;

  -- Aggregate professors by department into JSONB
  select json_agg(row_to_json(pltd)) into bsis_professors
  from (select * from public.professor_list_tb where department = 'BSIS' order by  CASE 
        WHEN final_grade IS NULL THEN 2
        ELSE 1
      END, final_grade desc) as pltd;

  select json_agg(row_to_json(pltd)) into bse_professors
  from (select * from public.professor_list_tb where department = 'BSE' order by  CASE 
        WHEN final_grade IS NULL THEN 2
        ELSE 1
      END, final_grade desc) as pltd;

  select json_agg(row_to_json(pltd)) into btvted_professors
  from (select * from public.professor_list_tb where department = 'BTVTED' order by  CASE 
        WHEN final_grade IS NULL THEN 2
        ELSE 1
      END, final_grade desc) as pltd;

  select json_agg(row_to_json(pltd)) into domt_professors
  from (select * from public.professor_list_tb where department = 'DOMT' order by  CASE 
        WHEN final_grade IS NULL THEN 2
        ELSE 1
      END, final_grade desc) as pltd;

  select json_agg(row_to_json(pltd)) into dict_professors
  from (select * from public.professor_list_tb where department = 'DICT' order by  CASE 
        WHEN final_grade IS NULL THEN 2
        ELSE 1
      END, final_grade desc) as pltd;

  -- Aggregate student_list_tb_data into JSONB
  select json_agg(row_to_json(sltd)) into student_list_tb_data
  from (select * from public.student_list_tb order by created_at asc) as sltd;

  -- Return the combined result as a structured JSONB object
  return jsonb_build_object(
      'dashboard', jsonb_build_object(
          'total_students', total_students,
          'total_evaluated', total_evaluated,
          'total_professor', total_professors
      ),
      'evaluation_forms', coalesce(evaluation_list_tb_data, '[]'::jsonb),
      'professors', jsonb_build_object(
          'bsisDep', coalesce(bsis_professors, '[]'::jsonb),
          'bseDep', coalesce(bse_professors, '[]'::jsonb),
          'btvtedDep', coalesce(btvted_professors, '[]'::jsonb),
          'domtDep', coalesce(domt_professors, '[]'::jsonb),
          'dictDep', coalesce(dict_professors, '[]'::jsonb)
      ),
      'students', coalesce(student_list_tb_data, '[]'::jsonb)
  );
end;
$$ language plpgsql set search_path = '';
