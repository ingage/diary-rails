export default class DashboardModule {
  private static readonly instance: DashboardModule = new DashboardModule();

  private constructor() {}

  static get(): DashboardModule {
    return DashboardModule.instance;
  }

  setup(): void {
    console.log('setup');
  }
}
