import { z } from 'zod';

export const updatePwdSchema = z
  .object({
    newPwd: z.string().min(8, { message: 'Must choose a new strong password.' }),
    confirmNewPwd: z.string()
  })
  .superRefine(({ newPwd, confirmNewPwd }, ctx) => {
    if (newPwd !== confirmNewPwd) {
      ctx.addIssue({
        code: 'custom',
        message: 'Must confirm password.',
        path: ['confirmNewPwd']
      });
    }
  });

export type UpdatePwdSchema = typeof updatePwdSchema;
