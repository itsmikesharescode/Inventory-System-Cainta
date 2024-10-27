export type TeacherType = {
  teacher_id: string;
  created_at: string;
  teacher_real_id: string;
  user_meta_data: {
    role: string;
    teacher_real_id: string;
    email: string;
    firstname: string;
    middlename: string;
    lastname: string;
    phonenumber: string;
    department: string;
  };
};
