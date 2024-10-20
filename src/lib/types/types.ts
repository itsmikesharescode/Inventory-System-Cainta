export type Result<T> = {
  status: number;
  type: string;
  data: T;
};
