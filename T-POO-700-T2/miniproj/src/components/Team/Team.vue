<template>
  <div>
    <TeamPopup :add-status-class="getTeams" ref="team_popup"></TeamPopup>

    <div id='Teams'>
      <div class="table-responsive">
        <table class="table table-hover table-dark">
          <!--<caption>List of teams</caption>-->

          <thead>
            <tr>
              <th tabindex="0" style="" data-field="i">
                <div class="th-inner both">#</div>
                <div class="fht-cell"></div>
              </th>

              <th tabindex="0" style="" data-field="name">
                <div class="th-inner both">Team</div>
                <div class="fht-cell"></div>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr class="table_row" v-for="row in data">
              <td style="display:none;">{{row.id}}</td>

              <td>{{row.i}}</td>

              <td>{{row.name}}</td>

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

  import TeamPopup from './TeamPopup.vue';

  const column_id = 0;
  const column_name = 2;

  ///===============================================================
  // event
  //===============================================================



  ///===============================================================
  //
  //===============================================================

  export default {
    name: 'Team',
    components: {
      TeamPopup
    },
    created() {
       this.getTeams()


       $(document).on('click','.table_row', (e) => {
         if(e.target.nodeName != "BUTTON")
           this.$refs.team_popup.showUpdateTeam(
              e.target.parentElement.childNodes[column_name].innerHTML,
              e.target.parentElement.childNodes[column_id].innerHTML);
          else
            this.$modals.confirm({
              message: 'Do you want to remove the team ' + e.target.parentElement.parentElement.childNodes[column_name].innerHTML + '?',
              onApprove: () => { this.deleteTeam(e.target.parentElement.parentElement.childNodes[column_id].innerHTML); },
              onCancel: () => {  },
            });
       });
    },
    data() {
      return {
        team_teamname: '',
        team_email: '',
        team_password: '',
        team_password_confirmation: '',
        team_id: 7,

        // display errors
        teamCreationError: 0,
        getTeamsError: 0,
        getTeamError: 0,
        teamUpdateError: 0,

        data: []
      };
    },
    methods: {
      //===============================================================
      // public
      //===============================================================


      //#############################################################
      getTeams: function (event) {
        get_request_serv("teams",
                          (success, response) => {
                            this.displayTeams(response.data);
                          });
      },

      //#############################################################
      deleteTeam: function (id) {
        delete_request_serv("teams/" + id,
                            (success, response) => {
                              this.getTeams();
                            });
      },

      //===============================================================
      // private
      //===============================================================

      //#############################################################
      displayTeams(teams) {
        this.data = [];

        for(var i = 0; i < Object.keys(teams.data).length; i++)
          this.data.push({
                          i: i+1,
                          name: teams.data[i].name,
                          id: teams.data[i].id
                        });

      }
    }
  }
</script>

<style>

</style>
