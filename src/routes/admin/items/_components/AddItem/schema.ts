import { z } from 'zod';

export const addItemSchema = z.object({
  deviceId: z.string().min(1, { message: 'Must enter a device id.' }),
  model: z.string().min(1, { message: 'Must enter a model.' }),
  category: z.string(),
  brand: z.string().min(1, { message: 'Must enter a brand.' }),
  description: z.string().min(1, { message: 'Must enter description.' }),
  quantity: z.number()
});

export type AddItemSchema = typeof addItemSchema;
