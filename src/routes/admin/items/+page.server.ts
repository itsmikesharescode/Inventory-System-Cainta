import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { addItemSchema } from './_components/AddItem/schema';
import { fail } from '@sveltejs/kit';
import { updateItemSchema } from './_components/UpdateItem/schema';

export const load: PageServerLoad = async () => {
  return {
    addItemForm: await superValidate(zod(addItemSchema)),
    updateItemForm: await superValidate(zod(updateItemSchema))
  };
};

export const actions: Actions = {
  addItemEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(addItemSchema));

    if (!form.valid) return fail(400, { form });

    console.log(form.data);
  },

  updateItemEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(updateItemSchema));

    if (!form.valid) return fail(400, { form });
  }
};
