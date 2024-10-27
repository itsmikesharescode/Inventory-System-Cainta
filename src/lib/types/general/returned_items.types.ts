import type { Item } from './borrowed_items.types';

export type ReturnedItemType = {
  id: number; // int8
  created_at: string; // timestamp
  teacher_real_id: string; // text
  reference_id: string; // text
  borrower_name: string; // text
  borrowed_date: string; // date
  returned_date: string; // date
  returned_items: Item[];
};
