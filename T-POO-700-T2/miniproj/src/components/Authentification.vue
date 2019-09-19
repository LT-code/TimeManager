<template>
  <div id='UserAuthentification'>
    <input type="text" v-model="user_email"/>
    <input type="text" v-model="user_password"/>

    <button v-on:click='signIn()'>Authentification</button>
    <div v-if="errorAuthentification == 1">
      <span>Error passord or email</span>
    </div>
  </div>
</template>

<script>
///===============================================================
//
//===============================================================
  import  {
            get_request_serv,
            post_request_serv
          } from "../js/http_request.js";

  import  {
            TM_TOKEN,
            set_token,
            get_cookie_token
          } from "../js/config.js";

  import passwordHash from 'password-hash'


  if(get_cookie_token())
    console.info("cookie exist, no authentification required");
  else
    console.info("cookie doesn't exist, authentification required");

  ///===============================================================
  //
  //===============================================================
  export default {
    name: 'ClockManager',
    components: {},
    data() {
      return {
        user_email: '',
        user_password: '',
        errorAuthentification: 0
      };
    },
    methods: {
      //===============================================================
      // public
      //===============================================================

      //#############################################################
      signIn: function (event) {
        post_request_serv("users/sign_in",
                          {
                              email: this.user_email,
                              password: this.user_password
                          },
                          (success, response) => {
                            if(success) {
                              set_token(response["data"].jwt);
                              this.errorAuthentification = 0;
                            }
                            else
                              this.errorAuthentification = 1;
                          });
      }
    }
  }
</script>

<style>

</style>
