<template>
  <div>
    <p>Users</p>
    <button v-on:click='logout'>Logout</button>
  </div>
</template>
<script>
import { mapActions } from 'vuex';

export default {
neme : 'Logout',
  methods: {
 ...mapActions(["logout"])
 }
  }
</script>