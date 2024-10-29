import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { sendReservationSchema } from './_components/SendReservation/schema';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async () => {
  return {
    sendReservationForm: await superValidate(zod(sendReservationSchema))
  };
};

export const actions: Actions = {
  sendResEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(sendReservationSchema));

    if (!form.valid) return fail(400, { form });
  }
};
