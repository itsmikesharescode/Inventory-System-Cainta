export type ItemBorrowed = {
  id: number;
  created_at: string;
  admin_id: string;
  device_id: string;
  model: string;
  category: string;
  type: string;
  status: string;
  mr: string;
  brand: string;
  quantity: number;
  price: number;
  description: string;
};

export type BorrowedItemType = {
  id: number;
  created_at: string;
  teacher_real_id: string;
  borrower_name: string;
  borrowed_date: string;
  room: string;
  items_borrowed: ItemBorrowed[];
};
