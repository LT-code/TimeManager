<template>
  <div>
    <head>
    	<title>Login Page</title>
        <!--Fontawesome CDN-->
    	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    </head>
      <div class="container">
      	<div class="d-flex justify-content-center h-100">
      		<div class="card">
      			<div class="card-header">
      				<h3>Sign Up</h3>
      			</div>
      			<div class="card-body">
      				<form>
                <div class="input-group form-group">
      						<div class="input-group-prepend">
      							<span class="input-group-text"><i class="fas fa-user"></i></span>
      						</div>
      						<input type="text" class="form-control" placeholder="username" v-model="user_username">
      					</div>

      					<div class="input-group form-group">
      						<div class="input-group-prepend">
      							<span class="input-group-text"><i class="fa-at fas"></i></span>
      						</div>
      						<input type="email" class="form-control" placeholder="email" v-model="user_email">
      					</div>

      					<div class="input-group form-group">
      						<div class="input-group-prepend">
      							<span class="input-group-text"><i class="fas fa-key"></i></span>
      						</div>
      						<input type="password" class="form-control" placeholder="password" v-model="user_password">
      					</div>

                <div class="input-group form-group">
      						<div class="input-group-prepend">
      							<span class="input-group-text"><i class="fas fa-key"></i></span>
      						</div>
      						<input type="password" class="form-control" placeholder="confirme password" v-model="user_password_confirmation">
      					</div>

                <div class="form-group">
                  <input type="button" value="Register" class="btn float-right login_btn" v-on:click='createUser()'>
                </div>

                <div v-if="userCreationError == 1">
                  <span>Error passord or email</span>
                </div>
      				</form>
            </div>
            <div class="card-footer">
      				<div class="d-flex justify-content-center links">
      					Have an account?
                <router-link to="/sign_in">Sign In</router-link>
      				</div>
      			</div>
      		</div>
      	</div>
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
          } from "../../js/http_request.js";

  import  {
            set_token
          } from "../../js/cookie.js";


  import passwordHash from 'password-hash'

  import router from "../../router"

  require('@/css/User/sign.css')


  ///===============================================================
  //
  //===============================================================
  export default {
    name: 'Register',
    components: {},
    data() {
      return {
        user_email: '',
        user_password: '',
        user_username: '',
        user_password_confirmation: '',
        errorAuthentification: 0
      };
    },
    methods: {
      //===============================================================
      // public
      //===============================================================

      //#############################################################
      createUser: function (event) {
        post_request_serv("users",
                          {
                            "user": {
                              email: this.user_email,
                              username: this.user_username,
                              role: 1,
                              password: this.user_password,
                              password_confirmation: this.user_password_confirmation
                            }
                          },
                          (success, response) => {
                            if(success) {
                              console.log(response.data);
                              router.push("/sign_in")
                            }
                            else
                              this.userCreationError = 1;
                          });
      }
    }
  }
</script>

<style>
  @import '../../css/User/sign.css';

  .card {
    height: 420px;
    width: 400px;
  }
</style>
