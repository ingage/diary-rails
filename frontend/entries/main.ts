import Vue from 'vue';
import '@p/compositionApi';
import pinia from '@p/pinia';
import router from '@p/vueRouter';
import vuetify from '@p/vuetify';

import App from '@v/App.vue';

new Vue({
  el: '#app',
  render: h => h(App),
  pinia: pinia,
  router: router,
  vuetify: vuetify,
});
