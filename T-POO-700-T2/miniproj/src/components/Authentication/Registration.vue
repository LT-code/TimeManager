<template>
	<div class="row" id="registration">
		<div class="col s12 m7">
			<div class="container">
				<div class="card hoverable">
					<div class="card-image">
						<img src="../../assets/bim-manager.jpg" alt="Time Manager">
						<span class="card-title text-black-50">Register</span>
					</div>
					<form @submit.prevent="onSubmit">
						<div class="input-field col s12">
							<i class="material-icons prefix">account_box</i>
							<label for="first_name">User Name</label>
							<input id="first_name" type="text" v-model="form.username">
						</div>
						<div class="input-field col s12">
							<i class="material-icons prefix">email</i>
							<label for="email">Your Email</label>
							<input type="email" id="email" class="validate" v-model="form.email">
						</div>
						<div class="input-field col s12">
							<i class="material-icons prefix">lock</i>
							<label for="password">Your Password</label>
							<input id="password" type="password" class="validate" v-model="form.password">
						</div>
						<div class="input-field col s12">
							<i class="material-icons prefix">lock</i>
							<label for="confirm_password">Confirm Password</label>
							<input id="confirm_password" type="password" class="validate" v-model="form.confirm_password">
						</div>
					</form>
					<div class="card-action">
						<button id="register" class="btn col-lg-4">
							<a href="#" class="offset-1 text-black-50">Register</a>
						</button>
					</div>
					<p>You already have an account ?
						<router-link to="/login">Log in...</router-link>
					</p>
				</div>
			</div>
		</div>
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
					username: '',
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

<style scoped>
	.card {
		width: 600px;
	}
</style>
