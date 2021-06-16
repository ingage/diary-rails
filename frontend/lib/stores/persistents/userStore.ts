import { defineStore } from 'pinia';
import User from '@/entities/User';

export const useUserStore = defineStore({
  id: 'user',

  // a function that returns a fresh state
  // TODO: あとから API で取ってくるようにする
  state: () => ({
    list: [
      new User({ email: 'nagata@ingage.jp', name: '永田' }),
      new User({ email: 'ishida@ingage.jp', name: '石田' }),
    ] as User[],
  }),

  // optional getters
  getters: {},

  // optional actions
  actions: {
    find(email: string): User | undefined {
      return this.list.find((c: User) => c.email === email);
    },
    async reload() {
      // TODO: API実装後、コメントアウトをはずす
      // const response = await new UserResource().query();
      // this.list = response.data;
    },
  },
});
