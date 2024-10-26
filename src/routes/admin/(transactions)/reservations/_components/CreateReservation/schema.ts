import { z } from 'zod';

const DATE_TIME_PATTERN = /^\d{2}:\d{2} (AM|PM)$/;
const DATE_TIME_FORMAT = 'HH:MM AM/PM';

export const createReservationSchema = z.object({
  teacherId: z.string().min(1, { message: 'Must enter teacher id.' }),
  teacherName: z.string().min(1, { message: 'Enter teacher name.' }),
  maxItems: z.number().nonnegative(),
  room: z.string().min(1, { message: 'Must enter a room.' }),
  date: z.string().min(1, { message: 'Must select date.' }),
  time: z.string().refine((v) => DATE_TIME_PATTERN.test(v), {
    message: `Time must be in format "${DATE_TIME_FORMAT}"`
  })
});

export type CreateReservationSchema = typeof createReservationSchema;
