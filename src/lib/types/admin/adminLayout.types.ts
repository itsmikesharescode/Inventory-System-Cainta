import type { ItemType } from '../general/items.types';
import type { TeacherType } from '../general/teachers.types';

export interface AdminLayout {
  teachers: TeacherType[] | [];
  items: ItemType[] | [];
}
