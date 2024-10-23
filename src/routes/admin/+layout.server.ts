import type { PostgrestSingleResponse } from '@supabase/supabase-js';
import type { LayoutServerLoad } from './$types';
import type { AdminLayout } from '$lib/types/admin/adminLayout.types';

export const load: LayoutServerLoad = async ({ locals: { supabase } }) => {
  const { data, error } = await supabase.rpc('admin_layout_load');
  console.log(data, error?.message);
  return {
    adminLayout: (await supabase.rpc('admin_layout_load')) as PostgrestSingleResponse<AdminLayout>
  };
};
