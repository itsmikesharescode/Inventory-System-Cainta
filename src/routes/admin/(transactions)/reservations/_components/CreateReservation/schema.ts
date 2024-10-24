import { z } from 'zod';

const DATE_TIME_PATTERN = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2} (AM|PM)$/;
const DATE_TIME_FORMAT = 'YYYY-MM-DD HH:MM AM/PM';

export const createReservationSchema = z.object({
  teacherId: z.string().min(1, { message: 'Must enter teacher id.' }),
  maxItems: z.number().nonnegative(),
  room: z
    .string()
    .refine((v) => ['room1', 'room2'].includes(v), { message: 'Must select a valid room.' }),
  date: z.string().min(1, { message: 'Must select date.' }),
  time: z.string().refine((v) => DATE_TIME_PATTERN.test(v), {
    message: `Time must be in format "${DATE_TIME_FORMAT}"`
  })
});

export type CreateReservationSchema = typeof createReservationSchema;
