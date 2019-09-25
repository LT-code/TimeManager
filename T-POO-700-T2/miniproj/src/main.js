<<<<<<< HEAD
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
=======
import Vue from "vue";
import App from "./App.vue";
import router from "./router";
//import store from "./store";

// js
import BootstrapVue from 'bootstrap-vue'
import JQuery from 'jquery'

Vue.use(BootstrapVue)
Vue.use(JQuery)

//css
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'


// vue
Vue.config.productionTip = false;

new Vue({
  router,
//  store,
  render: h => h(App)
}).$mount("#app");
>>>>>>> dev
