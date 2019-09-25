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
      				<h3>Sign In</h3>
      			</div>
      			<div class="card-body">
      				<form>
      					<div class="input-group form-group">
      						<div class="input-group-prepend">
      							<span class="input-group-text"><i class="fas fa-user"></i></span>
      						</div>
      						<input type="text" class="form-control" placeholder="email" v-model="user_email">

      					</div>
      					<div class="input-group form-group">
      						<div class="input-group-prepend">
      							<span class="input-group-text"><i class="fas fa-key"></i></span>
      						</div>
      						<input type="password" class="form-control" placeholder="password" v-model="user_password">
      					</div>
      					<div class="row align-items-center remember">
      						<input type="checkbox">Remember Me
      					</div>
                <div class="form-group">
                  <input type="button" value="Login" class="btn float-right login_btn" v-on:click='signIn()'>
                </div>
                <div v-if="errorAuthentification == 1">
                  <span>Error passord or email</span>
                </div>
      				</form>
      			</div>
      			<div class="card-footer">
      				<div class="d-flex justify-content-center links">
      					Don't have an account?
                <router-link to="/sign_up">Sign Up</router-link>
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

  ///===============================================================
  //
  //===============================================================
  export default {
    name: 'Authentification',
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
                              console.info("ok")
                              set_token(response["data"].jwt);
                              this.errorAuthentification = 0;
                              router.push("/")
                            }
                            else
                              this.errorAuthentification = 1;
                          });
      }
    }
  }
</script>

<style>/* Made with love by Mutiullah Samim*/

@import url('https://fonts.googleapis.com/css?family=Numans');

body {
  background-image: url('../../assets/gotham_city.jpg');/* url('http://getwallpapers.com/wallpaper/full/a/5/d/544750.jpg'); */
  background-size: cover;
  background-repeat: no-repeat;
  height: 100%;
  font-family: 'Numans', sans-serif;
}

.container{
height: 100%;
align-content: center;
}

.card{
height: 330px;
margin-top:25%;
margin-bottom:25%;
width: 400px;
background-color: rgba(0,0,0,0.7) !important;
}

.social_icon span{
font-size: 60px;
margin-left: 10px;
color: #FFC312;
}

.social_icon span:hover{
color: white;
cursor: pointer;
}

.card-header h3{
color: white;
}

.social_icon{
position: absolute;
right: 20px;
top: -45px;
}

.input-group-prepend span{
width: 50px;
background-color: #FFC312;
color: black;
border:0 !important;
}

input:focus{
outline: 0 0 0 0  !important;
box-shadow: 0 0 0 0 !important;

}

.remember{
color: white;
}

.remember input
{
width: 20px;
height: 20px;
margin-left: 15px;
margin-right: 5px;
}

.login_btn{
color: black;
background-color: #FFC312;
width: 100px;
}

.login_btn:hover{
color: black;
background-color: white;
}

.links{
color: white;
}

.links a{
margin-left: 4px;
}
</style>
