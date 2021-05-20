import '@mdi/font/css/materialdesignicons.css';

import Vue from 'vue';
import VueCompositionApi from '@vue/composition-api';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';

import Dashboard from '@c/Dashboard.vue';

Vue.use(VueCompositionApi);
Vue.use(Vuetify);

const v = new Vuetify({
  icons: {
    iconfont: 'mdi', // default - only for display purposes
  },
});

new Vue({
  el: '#app',
  render: h => h(Dashboard),
  vuetify: v,
});
