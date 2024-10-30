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
  sendResEvent: async ({ locals: { supabase, user }, request }) => {
    const form = await superValidate(request, zod(sendReservationSchema));

    if (!form.valid) return fail(400, { form });
    if (!user) return;

    const { error } = await supabase.rpc('add_reservation', {
      teacher_real_id_input: user.user_metadata.teacher_real_id,
      teacher_name_input: `${user.user_metadata.lastname}, ${user.user_metadata.firstname} ${user.user_metadata.middlename}`,
      max_items_input: form.data.maxItems,
      room_input: form.data.room,
      time_limit_input: `${form.data.date} ${form.data.time}`
    });
    console.log(error?.message);
    if (error) return fail(400, { form });
    return { form, msg: 'Reservation sent.' };
  }
};
