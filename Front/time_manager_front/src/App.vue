<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
import Team from './components/Team.vue'
import Registration from './components/Authentication/Registration.vue'
import Login from './components/Authentication/Login.vue'
import Logout from './components/Authentication/Logout.vue'
import store from './store.js' 




export default {
  name: 'app',
  components: {
    HelloWorld,
    Login,
    Registration,
    Logout,
    Team,
    store
  },
updated(){
 if (!store.state.accessToken)
 {
 if (this.$router.history.current.path != "/login" && this.$router.history.current.path != "/registration")
 this.$router.push('/login')
 }
 }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
