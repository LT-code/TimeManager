<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
//===============================================================
// import
//===============================================================
import  {
          get_cookie_token
        } from "./js/config.js";

///===============================================================
//
//===============================================================
  export default {
    name: 'app',
    components: {
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
