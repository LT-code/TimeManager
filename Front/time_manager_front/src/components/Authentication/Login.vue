<template>
  <div id="login">
      <b-form @submit="onSubmit">
        
        <b-form-group label="Email:" label-for="input-1">
            <b-form-input id="input-1" v-model="form.email" type="email" required placeholder="Enter email"></b-form-input>
        </b-form-group>

        <b-form-group label="Password:" label-for="input-2">
            <b-form-input id="input-2" v-model="form.password" required type="password" placeholder="Enter password"></b-form-input>
        </b-form-group>

      <b-button type="submit" variant="primary" >Submit</b-button>
    </b-form  >
  </div>
    
</template>

<script>
import axios from 'axios';
export default {
  name: 'Login',
  data() {
      return {
        form: {
          email: '',
          password: '',
          accessToken: ''
        },
        errors: []
      }
    },

    methods: {
      onSubmit() {
        

        axios.post('http://localhost:4000/api/users/sign_in', {
          
            email: this.form.email,
            password: this.form.password
          
         
        })
        .then((accessToken) => {
          console.log(accessToken.data);
          localStorage.setItem('accessToken',token.data.token);
          router.push('logout');
          
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
