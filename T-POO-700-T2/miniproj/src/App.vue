<template>
  <div id="app">
    <Authentification />
    <br/>
    <br/>
    <br/>
    <User msg="Welcome to Your Vue.js App"/>
    <br/>
    <br/>
    <br/>
    <Team />
  </div>
</template>

<script>
//===============================================================
// import
//===============================================================
  import  {
            get_cookie_token
          } from "./js/config.js";

  import User from './components/User.vue'
  import Authentification from './components/Authentification.vue'
  import Team from './components/Team.vue'

///===============================================================
//
//===============================================================
  export default {
    name: 'app',
    components: {
      User,
      Authentification,
      Team
    },
    created(){
       this.getCookie()
    },
    methods: {
      getCookie: function(event) {
        if(get_cookie_token())
          console.info("cookie exist, no authentification required");
        else
          console.info("cookie doesn't exist, authentification required");
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
