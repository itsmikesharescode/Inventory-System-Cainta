import type { BorrowedItemType } from '../general/borrowed_items.types';
import type { ItemType } from '../general/items.types';
import type { ReservationType } from '../general/reservations.types';
import type { TeacherType } from '../general/teachers.types';

export interface AdminLayout {
  teachers: TeacherType[] | [];
  items: ItemType[] | [];
  reservations: ReservationType[] | [];
  borrowed_items: BorrowedItemType[] | [];
}
