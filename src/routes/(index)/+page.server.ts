import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { loginSchema } from './schema';
import { zod } from 'sveltekit-superforms/adapters';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async () => {
  return {
    loginForm: await superValidate(zod(loginSchema))
  };
};

export const actions: Actions = {
  loginEvent: async ({ request, locals: { supabase } }) => {
    const form = await superValidate(request, zod(loginSchema));

    if (!form.valid) return fail(400, { form });

    const {
      data: { user },
      error
    } = await supabase.auth.signInWithPassword({
      email: form.data.email,
      password: form.data.pwd
    });

    if (error) return fail(401, { form, msg: error.message });
    else if (user) {
      return { form, msg: `Welcome back ${user.email}` };
    }

    return fail(401, { form, msg: 'Something wrong!' });
  }
};
