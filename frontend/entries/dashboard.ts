console.log('dashboard    dashboard');

import Vue from 'Vue';
import VueCompositionApi from '@vue/composition-api';
import Dashboard from '../components/Dashboard.vue';

Vue.use(VueCompositionApi);

new Vue({
  render: h => h(Dashboard),
}).$mount('#app');
