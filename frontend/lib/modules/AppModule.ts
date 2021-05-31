import { useAppStore } from '@/stores/appStore';
import { useCategoryStore } from '@/stores/persistents/categoryStore';

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
  }
}
