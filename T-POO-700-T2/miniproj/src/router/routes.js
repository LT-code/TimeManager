import home from '../components/HomePage'
import login from '../components/Authentication/Login'
import register from '../components/Authentication/Registration'

export default [
	{ path:'/', component: home },
	{ path:'/login', component: login },
	{ path:'/register', component: register }
]