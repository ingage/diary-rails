import Vue from 'vue';
import Router, { Route } from 'vue-router';
import {
  inject,
  InjectionKey,
  provide,
  reactive,
  SetupContext,
  UnwrapRef,
  watch,
} from '@vue/composition-api';
import DashboardPage from '@c/pages/DashboardPage.vue';

// vue3 に合わせて inject しておく
// TODO: vue3, vue-router-next に上がったら削除する
export const vueRouterKey: InjectionKey<Router> = Symbol('VueRouterKey');
export const vueRouteLocationKey: InjectionKey<UnwrapRef<Route>> = Symbol('VueRouteLocationKey');

export function useRouter(): Router {
  // vue 3 移行後は消えるので頑張らない
  // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
  return inject(vueRouterKey)!;
}

export function useRoute(): UnwrapRef<Route> {
  // vue 3 移行後は消えるので頑張らない
  // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
  return inject(vueRouteLocationKey)!;
}

export function setupRouter(context: SetupContext): void {
  provide(vueRouterKey, context.root.$router);

  const routeObject: Partial<Route> = {};
  const routeKeys = Object.keys(context.root.$route) as (keyof Route)[];
  routeKeys.forEach(key => {
    routeObject[key] = context.root.$route[key];
  });
  const reactiveRoute = reactive(routeObject);

  provide(vueRouteLocationKey, reactiveRoute);
  watch(
    () => context.root.$route.fullPath,
    () => {
      routeKeys.forEach(key => {
        reactiveRoute[key] = context.root.$route[key];
      });
    },
  );
}
// vue3 移行前対応ここまで

Vue.use(Router);

const routes = [
  {
    // 存在しないパスのリダイレクト用の設定
    path: '*',
    redirect: () => '/journals',
  },
  {
    // 自身のダッシュボードのページ
    name: 'main',
    path: '/',
    component: DashboardPage,
    props: () => ({}),
    // }, {
    //   // 日報を検索できるメインページ
    //   name: 'journals',
    //   path: '/journals',
    //   component: JournalsPage,
    //   props: (route: Route) => ({
    //     since: route.params.since,
    //     until: route.params.until,
    //     userEmails: route.params.userEmails ? route.params.userEmails : [],
    //   }),
    // }, {
    //   // 日報入力画面
    //   name: 'journals.edit',
    //   path: '/journals/edit/:date/userEmail',
    //   component: JournalsEditPage,
    //   props: (route: Route) => ({
    //     userEmail: route.params.userEmail,
    //     date: route.params.date,
    //   }),
    // }, {
    //   // カテゴリ一覧画面
    //   name: 'categories',
    //   path: '/categories',
    //   component: CategoriesPage,
    //   props: (route: Route) => ({
    //   }),
    // }, {
    //   // カテゴリ編集画面
    //   name: 'categories.edit',
    //   path: '/categories',
    //   component: CategoriesEditPage,
    //   props: (route: Route) => ({
    //   }),
  },
];

export const router = new Router({
  mode: 'hash',
  routes: routes,
});
export default router;
