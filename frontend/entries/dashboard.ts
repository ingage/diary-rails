import Vue from 'vue';
import '@p/compositionApi';
import vuetify from '@p/vuetify';
import pinia from '@p/pinia';

import Dashboard from '@c/pages/Dashboard.vue';

new Vue({
  el: '#app',
  render: h => h(Dashboard),
  pinia: pinia,
  vuetify: vuetify,
});
