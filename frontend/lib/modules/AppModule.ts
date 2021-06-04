import { useAppStore } from '@/stores/appStore';
import { useCategoryStore } from '@/stores/persistents/categoryStore';
import { useUserStore } from '@/stores/persistents/userStore';
import { useGroupStore } from '@/stores/persistents/groupStore';

export default class AppModule {
  private static readonly instance: AppModule = new AppModule();

  private constructor() {}

  static get(): AppModule {
    return AppModule.instance;
  }

  async setup(): Promise<void> {
    console.log('AppModule: setup');

    useAppStore().reload();
    await useCategoryStore().reload();
    await useUserStore().reload();
    await useGroupStore().reload();
  }
}
