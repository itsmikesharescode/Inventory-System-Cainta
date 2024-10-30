import type { PostgrestSingleResponse } from '@supabase/supabase-js';
import type { LayoutServerLoad } from './$types';
import type { TeacherLayout } from '$lib/types/teacher/teacherLayout.types';

export const load: LayoutServerLoad = async ({ locals: { supabase } }) => {
  return {
    teacherLayout: (await supabase.rpc(
      'teacher_layout_load'
    )) as PostgrestSingleResponse<TeacherLayout>
  };
};
