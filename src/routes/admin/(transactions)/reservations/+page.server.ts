import { superValidate } from 'sveltekit-superforms';
import type { Actions, PageServerLoad } from './$types';
import { zod } from 'sveltekit-superforms/adapters';
import { createReservationSchema } from './_components/CreateReservation/schema';
import { fail } from '@sveltejs/kit';
import { updateReservationSchema } from './_components/UpdateReservation/schema';

export const load: PageServerLoad = async ({ locals: { supabase }, depends, url }) => {
  //filter supabase here
  const filter = url.searchParams.get('filter');

  return {
    createReservationForm: await superValidate(zod(createReservationSchema)),
    updateReservationForm: await superValidate(zod(updateReservationSchema))
  };
};

export const actions: Actions = {
  createResEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(createReservationSchema));

    if (!form.valid) return fail(400, { form });

    const { error } = await supabase.from('reservations_tb').insert([
      {
        teacher_id: form.data.teacherId,
        teacher_name: form.data.teacherName,
        max_items: form.data.maxItems,
        room: form.data.room,
        time_limit: `${form.data.date} ${form.data.time}`,
        status: 'Pending'
      }
    ]);

    if (error) return fail(401, { form, msg: error.message });
    return { form, msg: 'Reservation created.' };
  },
  updateResEvent: async ({ locals: { supabase }, request }) => {
    const form = await superValidate(request, zod(updateReservationSchema));

    if (!form.valid) return fail(400, { form });

    const { error } = await supabase
      .from('reservations_tb')
      .update([
        {
          teacher_id: form.data.teacherId,
          teacher_name: form.data.teacherName,
          max_items: form.data.maxItems,
          room: form.data.room,
          time_limit: `${form.data.date} ${form.data.time}`,
          status: form.data.status
        }
      ])
      .eq('id', form.data.id);

    if (error) return fail(401, { form, msg: error.message });
    return { form, msg: 'Reservation updated.' };
  }
};
