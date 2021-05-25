import Vue from 'vue';
import '@p/compositionApi';
import vuetify from '@p/vuetify';

import Dashboard from '@c/Dashboard.vue';

new Vue({
  el: '#app',
  render: h => h(Dashboard),
  vuetify: vuetify,
});
