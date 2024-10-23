import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { createReservationSchema } from './_components/CreateReservation/schema';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async ({ locals: { supabase }, depends, url }) => {
  //filter supabase here
  const filter = url.searchParams.get('filter');

  return {
    createReservationForm: await superValidate(zod(createReservationSchema))
  };
};

export const actions: Actions = {
  createResEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(createReservationSchema));

    if (!form.valid) return fail(400, { form });
  }
};
