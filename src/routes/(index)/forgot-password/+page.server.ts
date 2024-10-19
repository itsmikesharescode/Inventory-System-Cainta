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

    const { error } = await supabase.auth.resetPasswordForEmail(form.data.email);

    if (error) return fail(401, { form, msg: error.message });
    return {
      form,
      msg: `An email containing password reset link has been sent to ${form.data.email}.`
    };
  }
};
