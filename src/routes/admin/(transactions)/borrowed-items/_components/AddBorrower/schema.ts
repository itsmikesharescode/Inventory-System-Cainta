import { z } from 'zod';

const borrowerNameSchema = z.object({
  teacher_id: z.string().min(1, { message: 'Must enter teacher ID.' }),
  created_at: z.string().min(1, { message: 'Must enter creation date.' }),
  user_meta_data: z.object({
    role: z.string().min(1, { message: 'Must enter role.' }),
    teacherId: z.string().min(1, { message: 'Must enter teacher ID.' }),
    email: z.string().email({ message: 'Must enter a valid email.' }),
    firstname: z.string().min(1, { message: 'Must enter first name.' }),
    middlename: z.string().min(1, { message: 'Must enter middle name.' }),
    lastname: z.string().min(1, { message: 'Must enter last name.' }),
    phonenumber: z.string().min(1, { message: 'Must enter phone number.' }),
    department: z.string().min(1, { message: 'Must enter department.' })
  })
});

export const addBorrowerSchema = z.object({
  borrowerName: borrowerNameSchema, // Use the defined schema for borrowerName
  borrowedDate: z.date({ message: 'Must enter a valid date.' }),
  itemsBorrowed: z.array(z.string()).min(1, { message: 'Must borrow at least one item.' }),
  room: z.string().min(1, { message: 'Must enter room.' })
});

export type AddBorrowerSchema = typeof addBorrowerSchema;
