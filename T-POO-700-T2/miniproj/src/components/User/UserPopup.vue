<template>
<div>
  <button class='btn btn-primary' v-on:click="showCreateUser()">Add User</button>

  <vudal name="user_form" id="user_form">
    <div class="header">
      <i class="close icon">&times;</i>
      <div v-if="user_creation" >Create User</div>
      <div v-if="user_update" >Update User</div>
    </div>
    <div class="form-style-8 content">
      <form>
        <input v-model="user_username" type="text" placeholder="Username" />
        <input v-model="user_email" type="email" placeholder="Email" />
        <input v-model="user_password" type="password" placeholder="Password" />
        <input v-model="user_password_confirmation" type="password" placeholder="Password Confirmation" />
        <Role/>
      </form>
      <div v-if="userCreationError == 1">
        <span>Error passord or email</span>
      </div>
    </div>
    <div class="actions">
      <button v-if="user_creation" v-on:click="createUser()" class="ui vudal-btn">Create</button>
      <button v-if="user_update" v-on:click="updateUser()" class="ui vudal-btn">Update</button>

      <button class="ui cancel vudal-btn">Cancel</button>
    </div>
  </vudal>

  <b-alert :show="dismissCountDown" dismissible variant="warning" @dismissed="dismissCountDown=0">
    Success
  </b-alert>

</div>
</template>

<script>
//===============================================================
// imports
//===============================================================
import Role from '../Role.vue'
import Vudal from '../../Plugin/Popup/index.js';

import  {
          post_request_serv,
          put_request_serv
        } from "../../js/http_request.js";

//===============================================================
//
//===============================================================

export default {
  name: 'UserPopup',
  components: {
    Vudal,
    Role
  },
  data() {
    return {
      user_email: '',
      user_password: '',
      user_username: '',
      user_password_confirmation: '',
      user_id: 0,
      userCreationError: 0,

      user_creation: false,
      user_update: false,

      dismissCountDown: 0,
      ErrorMessage: ''
    };
  },
  methods: {
    //===============================================================
    // public
    //===============================================================

    //#############################################################
    showCreateUser() {
      this.userCreationError = 0;
      this.user_creation = true;
      this.user_update = false;

      this.user_username = "";
      this.user_email = "";
      this.user_id = 0;

      this.$modals.user_form.$show();
    },

    //#############################################################
    showUpdateUser: function(username, email, user_id, role_id) {
      this.userCreationError = 0;
      this.user_creation = false;
      this.user_update = true;

      this.user_username = username;
      this.user_email = email;
      this.user_id = user_id;
  
      document.getElementById("select_roles").selectedIndex = role_id - 1

      this.$modals.user_form.$show();
    },

    //#############################################################
    createUser: function() {
      var e = document.getElementById("select_roles")
      post_request_serv("users",
                        {
                          "user": {
                            email: this.user_email,
                            username: this.user_username,
                            role: e.selectedIndex + 1,
                            password: this.user_password,
                            password_confirmation: this.user_password_confirmation
                          }
                        },
                        (success, response) => {
                          if(success) {
                            this.$modals.userCreation.hide();
                          }
                          else {
                            console.log(response);
                            this.userCreationError = 1;
                          }
                        });
        this.getUsers();
    },

    //#############################################################
    updateUser: function (event) {
      var e = document.getElementById("select_roles")

      var params;
      if(this.user_password == "" || this.user_password_confirmation == "")
        params = {
                  "user": {
                    id: this.user_id,
                    email: this.user_email,
                    username: this.user_username,
                    role: e.selectedIndex + 1
                  }
                }
      else
        params = {
                  "user": {
                    id: this.user_id,
                    email: this.user_email,
                    username: this.user_username,
                    role: e.selectedIndex + 1,
                    password: this.user_password,
                    password_confirmation: this.user_password_confirmation
                  }
                }


      put_request_serv("users/" + this.user_id,
                        params,
                        (success, response) => {
                          if(success) {
                            this.$modals.userCreation.hide();
                          }
                          else {
                            this.userCreationError = 1;
                            console.info(response);

                          }
                        });
      getUsers();
    }
  }
}
</script>

<style>
#user_form {
  width: 500px;
}

.form-style-8{
	font-family: 'Open Sans Condensed', arial, sans;
	/*width: 500px;*/
	padding: 10px;
	background: #FFFFFF;
	/*margin: 50px auto;
	/*box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.22);
	-moz-box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.22);
	-webkit-box-shadow:  0px 0px 15px rgba(0, 0, 0, 0.22);*/

}
.form-style-8 h2{
	background: #4D4D4D;
	text-transform: uppercase;
	font-family: 'Open Sans Condensed', sans-serif;
	color: #797979;
	font-size: 18px;
	font-weight: 100;
	padding: 20px;
	margin: -30px -30px 30px -30px;
}
.form-style-8 input[type="text"],
.form-style-8 input[type="date"],
.form-style-8 input[type="datetime"],
.form-style-8 input[type="email"],
.form-style-8 input[type="number"],
.form-style-8 input[type="search"],
.form-style-8 input[type="time"],
.form-style-8 input[type="url"],
.form-style-8 input[type="password"],
.form-style-8 textarea,
.form-style-8 select
{
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	outline: none;
	display: block;
	width: 100%;
	padding: 7px;
	border: none;
	border-bottom: 1px solid #ddd;
	background: transparent;
	margin-bottom: 10px;
	font: 16px Arial, Helvetica, sans-serif;
	height: 45px;
}
.form-style-8 textarea{
	resize:none;
	overflow: hidden;
}
.form-style-8 input[type="button"],
.form-style-8 input[type="submit"]{
	-moz-box-shadow: inset 0px 1px 0px 0px #45D6D6;
	-webkit-box-shadow: inset 0px 1px 0px 0px #45D6D6;
	box-shadow: inset 0px 1px 0px 0px #45D6D6;
	background-color: #2CBBBB;
	border: 1px solid #27A0A0;
	display: inline-block;
	cursor: pointer;
	color: #FFFFFF;
	font-family: 'Open Sans Condensed', sans-serif;
	font-size: 14px;
	padding: 8px 18px;
	text-decoration: none;
	text-transform: uppercase;
}
.form-style-8 input[type="button"]:hover,
.form-style-8 input[type="submit"]:hover {
	background:linear-gradient(to bottom, #34CACA 5%, #30C9C9 100%);
	background-color:#34CACA;
}

</style>
