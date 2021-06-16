import { UserResponseType } from '@/resources/UserResource';

export default class User {
  email = '';
  name = '';

  constructor(obj?: Partial<User>) {
    Object.assign(this, obj);
  }

  static createFromResponse(response: UserResponseType): User {
    const u = new User();
    u.email = response.email;
    u.name = response.name;
    return u;
  }
}
