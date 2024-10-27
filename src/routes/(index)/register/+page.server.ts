import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { registerSchema } from './schema';
import { zod } from 'sveltekit-superforms/adapters';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async () => {
  return {
    registerForm: await superValidate(zod(registerSchema))
  };
};

export const actions: Actions = {
  registerEvent: async ({ request, locals: { supabase } }) => {
    const form = await superValidate(request, zod(registerSchema));

    if (!form.valid) return fail(400, { form });

    const {
      data: { user },
      error
    } = await supabase.auth.signUp({
      email: form.data.email,
      password: form.data.pwd,
      options: {
        data: {
          role: 'teacher',
          teacher_id_real: form.data.teacherId,
          email: form.data.email,
          firstname: form.data.fName,
          middlename: form.data.mName,
          lastname: form.data.lName,
          phonenumber: form.data.phone,
          department: form.data.department
        }
      }
    });

    if (error) return fail(401, { form, msg: error.message });
    else if (user) return { form, msg: 'Account created.' };

    return fail(401, { msg: 'Something went bad.' });
  }
};
