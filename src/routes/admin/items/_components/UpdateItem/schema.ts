import { z } from 'zod';
import { categoriesMeta, statusMeta, typeMeta } from '../../metadata';

export const updateItemSchema = z.object({
  itemId: z.string(),
  deviceId: z.string().min(1, { message: 'Must enter a device id.' }),
  model: z.string().min(1, { message: 'Must enter a model.' }),
  category: z
    .string()
    .refine((v) => categoriesMeta.includes(v), { message: 'Must select category.' }),
  type: z.string().refine((v) => typeMeta.includes(v), { message: 'Must select type.' }),
  status: z.string().refine((v) => statusMeta.includes(v), { message: 'Must select status.' }),
  brand: z.string().min(1, { message: 'Must enter a brand.' }),
  mr: z.string().min(1, { message: 'Must enter mr.' }),
  price: z.number().gt(1, { message: 'Price must be greater than 1.' }),
  quantity: z.number().gt(1, { message: 'Quantity must be greater than 1.' }),
  description: z.string().min(1, { message: 'Must enter description.' })
});

export type UpdateItemSchema = typeof updateItemSchema;