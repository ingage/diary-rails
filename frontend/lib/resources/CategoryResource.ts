import BaseResource from '@/resources/BaseResource';
import Category from '@/entities/Category';
import { AxiosResponse } from 'axios';

export type CategoryResponseType = {
  id: string;
  name: string;
  group_id: string;
  capitalize_flag: boolean;
};

export class CategoryResource extends BaseResource {
  constructor() {
    super(`/api/v1/categories`);
  }

  async query(params = {}): Promise<AxiosResponse<Category[]>> {
    return super.requestGet<Category[]>('/', params, {
      transformResponse: (data: CategoryResponseType[]) => {
        return data.map(c => Category.createFromResponse(c));
      },
    });
  }
}
