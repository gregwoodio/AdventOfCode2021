export type User = {
  name: string;
  age: number;
};

export function isAdult(user: User): boolean {
  return user.age >= 18;
}
