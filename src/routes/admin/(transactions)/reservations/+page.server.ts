import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ locals: { supabase }, depends, url }) => {
  //filter supabase here
  const filter = url.searchParams.get('filter');
};
