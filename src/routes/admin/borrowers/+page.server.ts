import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { addTeacherSchema } from './_components/AddTeacher/schema';
import { fail } from '@sveltejs/kit';
import { updateTeacherSchema } from './_components/UpdateTeacher/schema';

export const load: PageServerLoad = async () => {
  return {
    addTeacherForm: await superValidate(zod(addTeacherSchema)),
    updateTeacherForm: await superValidate(zod(updateTeacherSchema))
  };
};

export const actions: Actions = {
  addTeacherEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(addTeacherSchema));

    if (!form.valid) return fail(400, { form });
  },

  updateTeacherEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(updateTeacherSchema));

    if (!form.valid) return fail(400, { form });
  }
};
