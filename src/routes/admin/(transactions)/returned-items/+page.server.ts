import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { addReturneSchema } from './_components/AddReturne/schema';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async () => {
  return {
    addReturneForm: await superValidate(zod(addReturneSchema))
  };
};

export const actions: Actions = {
  addReturneEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(addReturneSchema));

    if (!form.valid) return fail(400, { form });
    console.log(form.data);
  }
};
