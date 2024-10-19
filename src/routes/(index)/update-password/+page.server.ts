import { fail, superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { updatePwdSchema } from './schema';

export const load: PageServerLoad = async () => {
  return {
    updatePwdForm: await superValidate(zod(updatePwdSchema))
  };
};

export const actions: Actions = {
  updatePwdEvent: async ({ request, locals: { supabase } }) => {
    const form = await superValidate(request, zod(updatePwdSchema));

    if (!form.valid) return fail(400, { form });
  }
};
