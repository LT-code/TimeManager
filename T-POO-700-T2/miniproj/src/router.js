import Vue from 'vue'
import Router from 'vue-router'

const COMPONENT = "./components/"

//###################################################################

import  {
          is_token
        } from "./js/cookie.js";

Vue.use(Router)

//###################################################################

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'HomePage',
      component: () =>  import(COMPONENT + "HomePage.vue")
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
    // not found
    //=====================================
    {
      path: "/*",
      name: "fourofour",
      component: () => import(COMPONENT + "FourOFour.vue")
    }
  ]
})


//###################################################################

router.beforeEach((to, from, next) => {
  if(to.path != "/sign_in" && !is_token())
    next("/sign_in")
  //else
  //  if(to.path == "/sign_in")
  //    next("/")

  next()
})

export default router
