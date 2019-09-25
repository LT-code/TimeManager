import Vue from 'vue'
import Router from 'vue-router'
import App from './App.vue'
import FourOFour from './components/FourOFour.vue'

const COMPONENT = "./components/"

import  {
          is_token
        } from "./js/cookie.js";

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'App',
      component: App
    },
    //=====================================
    // User
    //=====================================
    {
      path: '/sign_in',
      name: 'Authentification',
      component: () =>  import(COMPONENT + "User/Authentification.vue")
    },
    {
      path: '/sign_up',
      name: 'User',
      component: () => import(COMPONENT + "User/Register.vue")
    },
    //=====================================
    // Not found
    //=====================================
    {
      path: "/*",
      name: "fourofour",
      component: FourOFour
    }
  ]
})

router.beforeEach((to, from, next) => {
  if(to.path != "/sign_in" && !is_token())
    next("/sign_in")
  //else
  //  if(to.path == "/sign_in")
  //    next("/")

  next()
})

export default router
