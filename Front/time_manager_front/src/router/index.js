import Vue from 'vue';
import Router from 'vue-router';

import HelloWorld from '@/components/HelloWorld.vue'
import Login from '@/components/Authentication/Login.vue'
import Registration from '@/components/Authentication/Registration.vue'

Vue.use(Router);

export default new Router({
    routes: [
        {
            path: '/hello-world',
            name: 'HelloWorld',
            component: HelloWorld
        },
        {
            path: '/registration',
            name: 'Registration',
            component: Registration
        },
        {
            path: '/login',
            name: 'Login',
            component: Login
        }
    ]
})