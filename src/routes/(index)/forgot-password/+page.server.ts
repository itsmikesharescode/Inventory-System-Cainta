import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { forgotPwdSchema } from './schema';
import { zod } from 'sveltekit-superforms/adapters';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async () => {
  return {
    forgotPwdForm: await superValidate(zod(forgotPwdSchema))
  };
};

export const actions: Actions = {
  forgotPwdEvent: async ({ request, locals: { supabase } }) => {
    const form = await superValidate(request, zod(forgotPwdSchema));

    if (!form.valid) return fail(400, { form });
  }
};
