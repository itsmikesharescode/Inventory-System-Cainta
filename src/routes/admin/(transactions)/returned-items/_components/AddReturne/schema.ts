import { z } from 'zod';

export const addReturneSchema = z.object({
  teacherId: z.string().min(1, { message: 'Must enter teacher id.' }),
  borrowerName: z.string().min(1, { message: 'Must enter borrower name.' }),
  borrowedDate: z.string().min(1, { message: 'Must enter borrowed date.' }),
  returnedDate: z.string().min(1, { message: 'Must enter returned date.' }),
  itemsReturned: z.array(z.any()).min(1, { message: 'Must borrow at least one item.' })
});

export type AddReturneSchema = typeof addReturneSchema;
