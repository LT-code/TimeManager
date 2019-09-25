<template>
	<div class="row">
		<div class="col s12 m7">
			<div v-if="loginError" class="errorMessage">{{ loginError }}</div>
			<div v-if="loginSuccessful" class="errorMessage">Successful Login</div>
			<div class="container">
				<div class="card hoverable">
					<div class="card-image">
						<img src="../assets/bim-manager.jpg" alt="Time Manager">
						<span class="card-title text-black-50">Login</span>
					</div>
					<form @submit.prevent="loginSubmit">
						<div class="input-field col s12">
							<i class="material-icons prefix">email</i>
							<label for="email">Your Email</label>
							<input type="email" id="email" class="validate" v-model="usermail">
						</div>
						<div class="input-field col s12">
							<i class="material-icons prefix">lock</i>
							<label for="password">Your Password</label>
							<input id="password" type="password" class="validate" v-model="password">
						</div>
					</form>
					<div class="card-action">
						<button id="register" class="btn col-lg-4 text-black-50" type="submit">Login</button>
					</div>
					<p>You don't have an account ?
						<router-link to="/register">Register...</router-link>
					</p>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	import { mapActions } from "vuex";

	export default {
		name: "Login",
		data() {
			return {
				usermail: '',
				password: '',

			}
		},
		methods: {
			...mapActions({
				getLoggedInStore: 'getLoggedIn'
			}),
			loginSubmit: function () {
				this.getLoggedInStore({ email: this.usermail, password: this.password })
			}
		},
		computed: {
			loading: function () {
				return this.$store.state.loading
			},
			loginError: function () {
				return this.$store.state.loginError
			},
			loginSuccessful: function () {
				return this.$store.state.loginSuccessful
			}
		}
	}
</script>

<style scoped>
	.card {
		width: 600px;
	}
</style>