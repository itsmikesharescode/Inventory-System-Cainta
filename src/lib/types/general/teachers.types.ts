export type TeacherType = {
  teacher_id: string;
  created_at: string;
  user_meta_data: {
    role: string;
    teacherId: string;
    email: string;
    firstname: string;
    middlename: string;
    lastname: string;
    phonenumber: string;
    department: string;
  };
};
