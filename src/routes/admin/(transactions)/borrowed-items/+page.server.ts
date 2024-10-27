import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { addBorrowerSchema } from './_components/AddBorrower/schema';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async () => {
  return {
    addBorrowerForm: await superValidate(zod(addBorrowerSchema))
  };
};

export const actions: Actions = {
  addBorrowerEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(addBorrowerSchema));

    if (!form.valid) return fail(400, { form });
    console.log(form.data);
  }
};