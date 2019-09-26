<template>
  <div>
    <UserPopup/>
    <div id='Users'>
      <div class="table-responsive">
        <table class="table table-hover table-dark">
          <caption>List of users</caption>
          <!--<thead>
            <tr>
              <th scope='col'>#</th>
              <th scope='col'>Username</th>
              <th scope='col'>Email</th>
            </tr>
          </thead>
          <tbody id="user_table">

          </tbody>-->
          <thead>
            <tr>
              <th tabindex="0" style="" data-field="Username">
                <div class="th-inner both">Item ID</div>
                <div class="fht-cell"></div>
              </th>
              <th tabindex="0" style="" data-field="Email">
                <div class="th-inner both">Item Name</div>
                <div class="fht-cell"></div>
              </th>
              <th tabindex="0" style="" data-field="id">
                <div class="th-inner both">Item Price</div>
                <div class="fht-cell"></div>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr  v-for="row in data">
              <td>{{row.Username}}</td>
              <td>{{row.Email}}</td>
              <td>{{row.id}}</td>
            </tr>
          </tbody>
        </table>
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
            post_request_serv,
            put_request_serv,
            delete_request_serv
          } from "../../js/http_request.js";

  import UserPopup from './UserPopup.vue'

  ///===============================================================
  //
  //===============================================================

  export default {
    name: 'User',
    components: {
      UserPopup
    },
    created(){
       this.getUsers()
    },
    data() {
      return {
        user_username: '',
        user_email: '',
        user_password: '',
        user_password_confirmation: '',
        user_id: 7,

        // display errors
        userCreationError: 0,
        getUsersError: 0,
        getUserError: 0,
        userUpdateError: 0,

        data: []
      };
    },
    methods: {
      //===============================================================
      // public
      //===============================================================

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

      displayUsers(users) {
        for(var i = 0; i < Object.keys(users.data).length; i++);
          this.data.push({
                          Username: users.data[i].username,
                          Email: users.data[i].email,
                          id: users.data[i].id
                        });
      },

      //#############################################################
      getUser_byid: function (event) {
        get_request_serv("users/" + this.user_id,
                          (success, response) => {
                            this.displayUsers(response.data);
                          });
      },

      //#############################################################
      getUsers: function (event) {
        get_request_serv("users",
                          (success, response) => {
                            this.displayUsers(response.data);
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

  ////#############################################################
  /*$(document).ready(function() {
    $('#user_table > tr').click(function() {
      this.getUsers();
      console.info("ok");
    });
  })*/
/*
  $(document).ready(function($) {
      $(".table_row").click(function() {
        console.info("ok");
          window.document.location = $(this).data("href");
      });
  });

  //#############################################################
  function validEmail() {
    const emailRegex = /^([A-Za-z0-9_\-.])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,4})$/;
    return emailRegex.test(this.user_email);
  }
/*
  //#############################################################
  function displayUser(user, number) {//(user, row) {
    var row = "<tr @click='alert(\"ok\")' class='table_row'>";
    row += "<th scope='row'>" + number + "</th>"
    row += "<td>" + user.username + "</td>";
    row += "<td>" + user.email + "</td>";
    //row += "<td><button class='btn' v-on:click='dze()'>Update</button></td>";
    //row += "<td><button class='btn' v-on:click='adz(" + user.id + ")'>Delete</button></td>";
    row += "<tr>";

    return row;
  }

  //#############################################################
  /*function displayUsers(users) {
    //$(".table_row").remove();

    for(var i = 0; i < Object.keys(users.data).length; i++)
      //$("#user_table").append(displayUser(users.data[i],i + 1));
      this.data.push({
                      Username: users.data[i].username,
                      Email: users.data[i].email,
                      id: users.data[i].id
                    })
  }*/
</script>

<style>

</style>
