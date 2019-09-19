<template>
  <div>
    <div id='User'>
      <input type="text" v-model="user_username"/>
      <input type="text" v-model="user_email" @change="validEmail()"/>
      <button v-on:click='createUser()'>Add User</button>

      <input type="hidden" v-model="user_id"/>
    </div>

    <div id='Users'>
      <button v-on:click='getUsers()'>Get Users</button>
      <table></table>
    </div>
  </div>
</template>

<script>
  import  {
            get_request_serv,
            post_request_serv,
            put_request_serv,
            delete_request_serv
          } from "../js/http_request.js";

  ///===============================================================
  //
  //===============================================================
  export default {
    name: 'User',
    components: {},
    data() {
      return {
        user_username: '',
        user_email: '',
        user_id: 7,

        // display errors
        userCreationError: 0,
        getUsersError: 0,
        getUserError: 0,
        userUpdateError: 0
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
                              username: this.user_username
                            }
                          },
                          (success, response) => {
                            if(response.status == 200)
                              console.log(response.data);
                            else
                              this.userCreationError = 1;
                          });
      },

      //#############################################################
      getUser: function (event) {
        get_request_serv("users?email=" + this.user_email + '&username=' + this.user_username,
                          (success, response) => {
                            if(response.status == 200)
                              console.log(response.data);
                            else
                              this.getUserError = 1;
                          });
      },

      //#############################################################
      getUser_byid: function (event) {
        get_request_serv("users/" + this.user_id,
                          (success, response) => {
                            displayUsers_tab(response.data);
                          });
      },

      //#############################################################
      getUsers: function (event) {
        get_request_serv("users",
                          (success, response) => {
                            displayUsers_tab(response.data);
                          });
      },

      //#############################################################
      updateUser: function (event) {
        put_request_serv("users/" + this.user_id,
                          {
                            "user": {
                              email: this.user_email,
                              username: this.user_username
                            }
                          },
                          (success, response) => {
                            if(response.status == 200)
                              console.log(rep.data);
                            else
                              this.userUpdateError = 1;
                          });
      },

      //#############################################################
      deleteUser: function (id) {
        delete_request_serv("users/" + id,
                            (success, response) => {
                              alert(success);
                            });
      }
    }
  }


  //===============================================================
  // private
  //===============================================================

  //#############################################################
  function validEmail() {
    const emailRegex = /^([A-Za-z0-9_\-.])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,4})$/;
    return emailRegex.test(this.user_email);
  }

  //#############################################################
  function displayUser(user, row) {
    console.log(user);
    var td1 = row.insertCell();
    td1.innerHTML =  user.username;
    var td2 = row.insertCell();
    td2.innerHTML = user.email;
    var td_update = row.insertCell();
    td_update.innerHTML = "<button v-on:click='createUser()'>Update</button>";
    var td_delete = row.insertCell();
    td_delete.innerHTML = "<button v-on:click='deleteUser(" + user.id + ")'>Delete</button>";

    row.appendChild(td1);
    row.appendChild(td2);
    row.appendChild(td_update);
    row.appendChild(td_delete);

    return row;
  }

  //#############################################################
  function displayUsers(users, tab) {
    console.log(users.data);
    for(var i = 0; i < Object.keys(users.data).length; i++)
      tab.appendChild(displayUser(users.data[i],tab.insertRow()));

    return tab;
  }

  //#############################################################
  function displayUsers_tab(users) {
    var div = document.getElementById('Users'),
        tab  = document.createElement('table');
    tab.style.width  = '100px';
    tab.style.border = '1px solid black';

    displayUsers(users, tab);

    div.appendChild(tab);
  }
</script>

<style>

</style>
