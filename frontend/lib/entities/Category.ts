import { CategoryResponseType } from '@/resources/CategoryResource';

export default class Category {
  id = '';
  name = '';
  groupId = '';
  capitalizeFlag = false;

  static createFromResponse(response: CategoryResponseType): Category {
    const c = new Category();
    c.id = response.id;
    c.name = response.name;
    c.groupId = response.group_id;
    c.capitalizeFlag = response.capitalize_flag;

    return c;
  }
}
