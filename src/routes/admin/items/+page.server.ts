import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { addItemSchema } from './_components/AddItem/schema';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async () => {
  return {
    addItemForm: await superValidate(zod(addItemSchema))
  };
};

export const actions: Actions = {
  addItemEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(addItemSchema));

    if (!form.valid) return fail(400, { form });

    console.log(form.data);
  }
};
