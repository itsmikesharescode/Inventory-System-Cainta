import { fail, superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { updatePwdSchema } from './schema';
import { redirect } from '@sveltejs/kit';

export const load: PageServerLoad = async ({ locals: { supabase }, url }) => {
  const { data, error } = await supabase.auth.verifyOtp({
    token_hash: url.searchParams.get('token') ?? '',
    type: 'email'
  });

  if (error) redirect(303, `/?error=${error.message.split(' ').join('-').toLocaleLowerCase()}`);

  return {
    updatePwdForm: await superValidate(zod(updatePwdSchema))
  };
};

export const actions: Actions = {
  updatePwdEvent: async ({ request, locals: { supabase } }) => {
    const form = await superValidate(request, zod(updatePwdSchema));

    if (!form.valid) return fail(400, { form });

    const {
      data: { user },
      error
    } = await supabase.auth.updateUser({
      password: form.data.newPwd
    });

    if (error) return fail(401, { form, msg: error.message });
    else if (user) return { form, msg: 'Password updated.' };
    return fail(401, { form, msg: 'Something went wrong.' });
  }
};
