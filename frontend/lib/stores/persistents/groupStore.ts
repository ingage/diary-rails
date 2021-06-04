import { defineStore } from 'pinia';
import Group from '@/entities/Group';

export const useGroupStore = defineStore({
  id: 'group',

  // a function that returns a fresh state
  // TODO: あとから API で取ってくるようにする
  state: () => ({
    list: [
      new Group({ id: 'dev', name: '開発部' }),
      new Group({ id: 'cs', name: 'CS部' }),
    ] as Group[],
  }),

  // optional getters
  getters: {},

  // optional actions
  actions: {
    find(id: string): Group | undefined {
      return this.list.find((c: Group) => c.id === id);
    },
    async reload() {
      // TODO: API実装後、コメントアウトをはずす
      // const response = await new GroupResource().query();
      // this.list = response.data;
    },
  },
});
