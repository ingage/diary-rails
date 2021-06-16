import { GroupResponseType } from '@/resources/GroupResource';

export default class Group {
  id = '';
  name = '';

  constructor(obj?: Partial<Group>) {
    Object.assign(this, obj);
  }

  static createFromResponse(response: GroupResponseType): Group {
    const u = new Group();
    u.id = response.id;
    u.name = response.name;
    return u;
  }
}
