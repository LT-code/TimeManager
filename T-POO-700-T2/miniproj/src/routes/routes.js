import home from '../components/HomePage'
import login from '../components/Login'
import register from '../components/Register'

export default [
	{ path:'/', component: home },
	{ path:'/login', component: login },
	{ path:'/register', component: register }
]