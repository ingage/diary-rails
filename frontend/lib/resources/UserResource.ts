import BaseResource from '@/resources/BaseResource';
import User from '@/entities/User';
import { AxiosResponse } from 'axios';

export type UserResponseType = {
  email: string;
  name: string;
};

export class UserResource extends BaseResource {
  constructor() {
    super(`/api/v1/users`);
  }

  async query(params = {}): Promise<AxiosResponse<User[]>> {
    return super.requestGet<User[]>('/', params, {
      transformResponse: (data: UserResponseType[]) => {
        return data.map(c => User.createFromResponse(c));
      },
    });
  }
}
