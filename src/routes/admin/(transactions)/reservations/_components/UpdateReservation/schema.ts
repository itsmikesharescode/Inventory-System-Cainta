import { z } from 'zod';

export const updateReservationSchema = z.object({
  id: z.number(),
  name: z.string().min(1, { message: 'Must enter a valid name.' }),
  item: z.string().min(1, { message: 'Must enter a valid item.' }),
  reservationDate: z.string().min(1, { message: 'Must enter a reservation date.' }),
  room: z.string().min(1, { message: 'Must enter a valid room.' })
});

export type UpdateReservationSchema = typeof updateReservationSchema;
