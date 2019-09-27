<template>
  <div>
    <UserPopup :add-status-class="getUsers" ref="user_popup"></UserPopup>

    <div id='Users'>
      <div class="table-responsive">
        <table class="table table-hover table-dark">
          <!--<caption>List of users</caption>-->

          <thead>
            <tr>
              <th tabindex="0" style="" data-field="number">
                <div class="th-inner both">#</div>
                <div class="fht-cell"></div>
              </th>

              <th tabindex="0" style="" data-field="Username">
                <div class="th-inner both">User</div>
                <div class="fht-cell"></div>
              </th>

              <th tabindex="0" style="" data-field="Email">
                <div class="th-inner both">Email</div>
                <div class="fht-cell"></div>
              </th>

              <th tabindex="0" style="" data-field="Role">
                <div class="th-inner both">Email</div>
                <div class="fht-cell"></div>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr class="table_row" v-for="row in data">
              <td style="display:none;">{{row.id}}</td>

              <td>{{row.i}}</td>

              <td>{{row.Username}}</td>

              <td>{{row.Email}}</td>

              <td>{{row.Role}}</td>

              <td style="display:none;">{{row.Id_Role}}</td>

              <td><button v-on:click.native="confirm()">Delete</button></td>
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

  import UserPopup from './UserPopup.vue';

  const column_id = 0;
  const column_email = 3;
  const column_username = 2;
  const column_i = 1;
  const column_role = 4;
  const column_id_role = 5;

  ///===============================================================
  // event
  //===============================================================



  ///===============================================================
  //
  //===============================================================

  export default {
    name: 'User',
    components: {
      UserPopup
    },
    created() {
       this.getUsers()


       $(document).on('click','.table_row', (e) => {
         if(e.target.nodeName != "BUTTON")
           this.$refs.user_popup.showUpdateUser(
              e.target.parentElement.childNodes[column_username].innerHTML,
              e.target.parentElement.childNodes[column_email].innerHTML,
              e.target.parentElement.childNodes[column_id].innerHTML,
              e.target.parentElement.childNodes[column_id_role].innerHTML);
          else
            this.$modals.confirm({
              message: 'Do you want to remove the user ' + e.target.parentElement.parentElement.childNodes[column_username].innerHTML + '?',
              onApprove: () => { this.deleteUser(e.target.parentElement.parentElement.childNodes[column_id].innerHTML); },
              onCancel: () => {  },
            });
       });
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
                            if(success)
                              console.log(response.data);
                            else
                              this.getUserError = 1;
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
      deleteUser: function (id) {
        delete_request_serv("users/" + id,
                            (success, response) => {
                              this.getUsers();
                            });
      },

      //===============================================================
      // private
      //===============================================================

      //#############################################################
      displayUsers(users) {
        var role_lib;
        this.data = [];

        for(var i = 0; i < Object.keys(users.data).length; i++) {
          switch(users.data[i].role) {
            case 1:
              role_lib = "User"
              break;
            case 2:
              role_lib = "Manager"
              break;
            case 3:
              role_lib = "General Manager"
              break;
            default:
              role_lib = "not defined"
          }

          this.data.push({
                          i: i+1,
                          Username: users.data[i].username,
                          Email: users.data[i].email,
                          id: users.data[i].id,
                          Role: role_lib,
                          Id_Role: users.data[i].role
                        });
        }
      }
    }
  }
</script>

<style>

</style>
