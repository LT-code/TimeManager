<template>
<div>
  <button class='btn btn-primary' v-on:click="showCreateTeam()">Add team</button>

  <vudal name="team_form" id="team_form">
    <div class="header">
      <i class="close icon">&times;</i>
      <div v-if="team_creation" >Create Team</div>
      <div v-if="team_update" >Update Team</div>
    </div>
    <div class="form-style-8 content">
      <form>
        <input v-model="team_name" type="text" placeholder="name" />
      </form>
      <div v-if="teamCreationError == 1">
        <span>Error passord or email</span>
      </div>
    </div>
    <div class="actions">
      <button v-if="team_creation" v-on:click="createTeam()" class="ui vudal-btn">Create</button>
      <button v-if="team_update" v-on:click="updateTeam()" class="ui vudal-btn">Update</button>

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
import Vudal from '../../Plugin/Popup/index.js';

import  {
          post_request_serv,
          put_request_serv
        } from "../../js/http_request.js";

//===============================================================
//
//===============================================================

export default {
  name: 'TeamPopup',
  components: {
    Vudal
  },
  data() {
    return {
      team_name: '',
      team_id: 0,

      team_creation: false,
      team_update: false,

      teamCreationError: 0,

      dismissCountDown: 0,
      ErrorMessage: ''
    };
  },
  methods: {
    //===============================================================
    // public
    //===============================================================

    //#############################################################
    showCreateTeam() {
      this.teamCreationError = 0;
      this.team_creation = true;
      this.team_update = false;

      this.team_name = ""
      this.team_id = 0;

      this.$modals.team_form.$show();
    },

    //#############################################################
    showUpdateTeam: function(name,team_id) {
      this.teamCreationError = 0;
      this.team_creation = false;
      this.team_update = true;

      this.team_name = name;
      this.team_id = team_id;

      this.$modals.team_form.$show();
    },

    //#############################################################
    createTeam: function() {
      var e = document.getElementById("select_roles")
      post_request_serv("teams",
                        {
                          "team": {
                            name: this.team_name
                          }
                        },
                        (success, response) => {
                          if(success) {
                            this.$modals.team_form.hide();
                            this.$parent.getTeams();
                          }
                          else {
                            console.log(response);
                            this.teamCreationError = 1;
                          }
                        });
    },

    //#############################################################
    updateTeam: function (event) {
      var e = document.getElementById("select_roles")


      put_request_serv("teams/" + this.team_id,
                        {
                          "team": {
                            name: this.team_name
                          }
                        },
                        (success, response) => {
                          if(success) {
                            this.$modals.team_form.hide();
                            this.$parent.getTeams();
                          }
                          else {
                            this.teamCreationError = 1;
                            console.info(response);

                          }
                        });
    },
  }
}
</script>

<style>
#team_form {
  width: 500px;
}

@import '../../css/popup.css';

</style>
