import { defineStore } from 'pinia';
import Category from '@/entities/Category';
import { CategoryResource } from '@/resources/CategoryResource';

export const useCategoryStore = defineStore({
  id: 'category',

  // a function that returns a fresh state
  state: () => ({
    list: [] as Category[],
  }),

  // optional getters
  getters: {},

  // optional actions
  actions: {
    find(id: string): Category | undefined {
      return this.list.find((c: Category) => c.id === id);
    },
    async reload() {
      const response = await new CategoryResource().query();
      this.list = response.data;
    },
  },
});
