import BaseResource from '@/resources/BaseResource';
import Group from '@/entities/Group';
import { AxiosResponse } from 'axios';

export type GroupResponseType = {
  id: string;
  name: string;
};

export class GroupResource extends BaseResource {
  constructor() {
    super(`/api/v1/groups`);
  }

  async query(params = {}): Promise<AxiosResponse<Group[]>> {
    return super.requestGet<Group[]>('/', params, {
      transformResponse: (data: GroupResponseType[]) => {
        return data.map(c => Group.createFromResponse(c));
      },
    });
  }
}
