<template>
  <div>
    <div id='User'>
      <input type="text" v-model="user_username"/>
      <input type="text" v-model="user_email" @change="validEmail()"/>
      <button v-on:click='createUser()'>Add User</button>
   
      <div id="app">
        <button id="show-modal" @click="showModal = true">Show Modal</button>
        <!-- use the modal component, pass in the prop -->
        <modal v-if="showModal" @close="showModal = false">
          <!--
            you can use custom content here to overwrite
            default content
          -->
          <h3 slot="header">custom header</h3>
        </modal>
      </div>

        <transition name="modal">
          <div class="modal-mask">
            <div class="modal-wrapper">
              <div class="modal-container">

                <div class="modal-header">
                  <slot name="header">
                    default header
                  </slot>
                </div>

                <div class="modal-body">
                  <slot name="body">
                    default body
                  </slot>
                </div>

                <div class="modal-footer">
                  <slot name="footer">
                    default footer
                    <button class="modal-default-button" @click="$emit('close')">
                      OK
                    </button>
                  </slot>
                </div>
              </div>
            </div>
          </div>
      </transition>


      <input type="hidden" v-model="user_id"/>
    </div>

    <div id='Users'>
      <button v-on:click='getUsers()'>Get Users</button>
      <table v-model="t"></table>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';
  import {TM_URL} from "../config.js";

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
        userUpdate: 0
      };
    },
    methods: {
      //===============================================================
      // public
      //===============================================================

      //#############################################################
      createUser: function (event) {
        axios.post(TM_URL + "users", {
                                                "user": {
                                                  email: this.user_email,
                                                  username: this.user_username
                                                }
                                              })
        .then ((response) => {
          if(response.status == 200)
            console.log(response.data);
          else
            this.userCreationError = 1;
        });
      },

      show () {
        this.$modal.show('hello-world');
      },
      hide () {
        this.$modal.hide('hello-world');
      },

      //#############################################################
      getUser: function (event) {
        axios.get(TM_URL + "users?email=" + this.user_email + '&username=' + this.user_username)
        .then ((response) => {
          if(response.status == 200)
            console.log(response.data);
          else
            this.getUserError = 1;
        });
      },

      //#############################################################
      getUser_byid: function (event) {
        axios.get(TM_URL + "users/" + this.user_id).then ((response) => {
          if(response.status == 200) {
            console.log(response.data);
            displayUsers_tab(response.data);
          }
          elsecoucou
            this.getUsersError = 1;
        });
      },

      //#############################################################
      getUsers: function (event) {
        axios.get(TM_URL + "users").then ((response) => {
          if(response.status == 200) {
            console.log(response.data);
            displayUsers_tab(response.data);
          }
          else
            this.getUsersError = 1;
        });
      },
      
      //#############################################################
      updateUser: function (event) {
        axios.put(TM_URL + "users/" + this.user_id, {
                                                "user": {
                                                  email: this.user_email,
                                                  username: this.user_username
                                                }
                                              })
        .then ((response) => {
          if(response.status == 200)
            console.log(response.data);
          else
            this.userCreationError = 1;
        });
      },

      //#############################################################
      deleteUser: function (id) {
        alert(id);
        axios.delete(TM_URL + "users/" + id).then ((response) => {
          if(response.status == 200)
            console.log(response.data);
          else
            this.getUsersError = 1;
        });
      }
    }
  }
</script>

<style>
  .modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .5);
  display: table;
  transition: opacity .3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  width: 300px;
  margin: 0px auto;
  padding: 20px 30px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}

.modal-header h3 {
  margin-top: 0;
  color: #42b983;
}

.modal-body {
  margin: 20px 0;
}

.modal-default-button {
  float: right;
}

/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>
