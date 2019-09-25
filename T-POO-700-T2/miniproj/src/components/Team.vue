<template>
  <div>
    <input type="text" v-model="team_name"/>
    <button v-on:click='addTeam()'>Add Team</button>
  </div>
</template>

<script>
  import  {
            post_request_serv
          } from "../js/http_request.js";


  export default {
    name: 'Team',
    components: {},
    data() {
      return {
        team_name: ''
      };
    },
    methods: {
      addTeam: function (event) {
        post_request_serv("teams",
                          {
                            "team": {
                              name: this.team_name
                            }
                          },
                          (success, response) => {
                            console.log(response);
                          });
      }
    }
  }
</script>

<style>

</style>
