import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { loginSchema } from './components/Login/schema';
import { registerSchema } from './components/Register/schema';
import { zod } from 'sveltekit-superforms/adapters';
import { fail } from '@sveltejs/kit';
import { forgotPwdSchema } from './components/ForgotPwd/schema';

export const load: PageServerLoad = async () => {
  return {
    loginForm: await superValidate(zod(loginSchema)),
    registerForm: await superValidate(zod(registerSchema)),
    forgotPwdForm: await superValidate(zod(forgotPwdSchema))
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
      password: form.data.password
    });

    if (error) return fail(401, { form, msg: error.message });

    return { form, msg: `Welcome back ${user?.email}` };
  },

  registerEvent: async ({ request, locals: { supabase } }) => {
    const form = await superValidate(request, zod(registerSchema));

    if (!form.valid) return fail(400, { form });

    const { error } = await supabase.auth.signUp({
      email: form.data.email,
      password: form.data.pwd,
      options: {
        data: {
          role: 'teacher',
          fName: form.data.fName,
          mName: form.data.mName,
          lName: form.data.lName,
          teacherId: form.data.teacherId,
          phone: form.data.phone,
          department: form.data.department
        }
      }
    });

    if (error) return fail(401, { form, msg: error.message });

    return { form, msg: 'Account created successfully' };
  },

  forgotPwdEvent: async ({ request, locals: { supabase } }) => {
    const form = await superValidate(request, zod(forgotPwdSchema));

    if (!form.valid) return fail(400, { form });

    const { error } = await supabase.auth.resetPasswordForEmail(form.data.email);

    if (error) return fail(401, { form, msg: error.message });

    return { form, msg: 'Reset link sent successfully' };
  }
};
