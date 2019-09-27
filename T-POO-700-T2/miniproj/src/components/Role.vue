<template>
  <div>
    <select id="select_roles" v-model="select_roles">
    </select>
  </div>
</template>

<script>
  //===============================================================
  //
  //===============================================================
  import  {
            get_request_serv,
          } from "../js/http_request.js";
  import  {
            is_token,
          } from "../js/cookie.js";

  //===============================================================
  //
  //===============================================================
  export default {
    name: 'Role',
    components: {},
    data() {
      return {
        select_roles: ''
      };
    },
    created() {
      // get roles
      if(is_token())
        get_request_serv("roles",
                          (success, response) => {
                            console.info(success);
                            if(success)
                              displayRoles(response.data);
                          });
      else
        setTimeout(getRoles, 100);
    }
  }

  //===============================================================
  //
  //===============================================================

  //#############################################################

  function displayRoles(roles) {
    var select = document.getElementById("select_roles");

    for(var i = 0; i < Object.keys(roles.data).length; i++) {
      var opt  = document.createElement('option');
      opt.innerHTML = roles.data[i].name;
      select.appendChild(opt);
    }
  }
</script>

<style>

</style>
