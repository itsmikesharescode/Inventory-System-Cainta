export interface GraphCountsType {
  pending: {
    day: string;
    count: number;
  }[];
  accepted: {
    day: string;
    count: number;
  }[];
  canceled: {
    day: string;
    count: number;
  }[];
  reservations: {
    day: string;
    count: number;
  }[];
}
