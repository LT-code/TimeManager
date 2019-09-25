<template>
  <div class="registration">
    <b-form @submit="onSubmit">

        <b-form-group label="Username:" label-for="input-1">
            <b-form-input id="input-1" v-model="form.username" required placeholder="Enter your username"></b-form-input>
        </b-form-group>
        
        <b-form-group label="Email:" label-for="input-2">
            <b-form-input id="input-2" v-model="form.email" type="email" required placeholder="Enter email"></b-form-input>
        </b-form-group>

        <b-form-group label="Password:" label-for="input-3">
            <b-form-input id="input-3" v-model="form.password" required type="password" placeholder="Enter password"></b-form-input>
        </b-form-group>

        <b-form-group label="Confirm Password:" label-for="input-4">
            <b-form-input id="input-4" v-model="form.confirm_password" required type="password" placeholder="Confirm password"></b-form-input>
        </b-form-group>

      <b-button type="submit" variant="primary">Submit</b-button>
    </b-form>
  </div>
    
</template>

<script>

import axios from 'axios';
import Swal from 'sweetalert2';

export default {
  name: 'Registration',
  
  data() {
      return {
        form: {
          email: '',
          username  : '',
          password: '',
          confirm_password: ''
        },
        errors: []
      }
    },

    methods: {
      onSubmit() {

        if (this.form.password !== this.form.confirm_password) {
          Swal.fire({
            title: 'Error',
            text: 'Les mots de passes ne sont pas identiques',
            type: 'error',
            confirmButtonText: 'Réessayez'
          })
        }


        this.user = {
            username: this.form.username,
            email: this.form.email,
            password: this.form.password,
            confirm_password: this.form.confirm_password,
            role: 1
        }

        axios.post('http://localhost:4000/api/users/sign_up', {
          user: {
            username: this.user.username,
            email: this.user.email,
            password: this.user.password,
            password_confirmation: this.user.confirm_password,
            role: this.user.role
          }
        })
        .then((response) => {
          console.log('ok')
        })
        .catch((error) => {
          console.log(error)
        });


        
      }
    } 
  
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
