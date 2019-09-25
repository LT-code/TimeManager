import Vue from 'vue'
import App from './App.vue'
import BootstrapVue from 'bootstrap-vue';
import VueRouter from 'vue-router'
import Routes from './router/routes'
import store from './stores/loginStore'

Vue.config.productionTip = false;
Vue.use(BootstrapVue);
Vue.use(VueRouter);

const router = new VueRouter({
  routes: Routes,
  mode: 'history'
});

new Vue({
  render: h => h(App),
  router: router,
  store: store,
}).$mount('#app');