<template>
	<div class="row">
		<div class="col s12 m7">
			<div class="container">
				<div class="card hoverable">
					<div class="card-image">
						<img src="../assets/bim-manager.jpg">
						<span class="card-title text-black-50">Register</span>
					</div>
					<form>
						<div class="input-field col s12">
							<i class="material-icons prefix">account_box</i>
							<label for="first_name">First Name</label>
							<input id="first_name" type="text" v-model="firstname">
						</div>
						<div class="input-field col s12">
							<i class="material-icons prefix">account_box</i>
							<label for="last_name">Last Name</label>
							<input id="last_name" type="text" v-model="lastname">
						</div>
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
						<button id="register" class="btn col-lg-4"><a href="#" class="offset-1 text-black-50">Register</a></button>
					</div>
					<p>You already have an account ? <a href="">Log in...</a></p>
					<div v-if="authenticationError === 1">
						<span>Error on password or email</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--
	<section class="section container jumbotron" id="login">
		<h1 class="display-4">Login</h1>
		<div class="row">
			<div class="col s12 l6">
				<form>
					<div class="input-field">
						<i class="material-icons prefix">email</i>
						<input type="email" id="email">
						<label for="email">Your Email</label>
					</div>
					<div class="input-field">
						<i class="material-icons prefix">lock</i>
						<textarea id="message" class="materialize-textarea" cols="20" rows="20"></textarea>
						<label for="message">Your Password</label>
					</div>
					<div class="input-field center">
						<button class="btn col-lg-6">Login</button>
						<button class="btn col-lg-6">Register</button>
					</div>
				</form>
			</div>
		</div>
	</section>
-->
</template>

<script>
	import { post_request_serv } from "@/js/http_request";
	import { set_token } from "@/js/config";

	export default {
		name: "Login",
		data() {
			return {
				usermail: '',
				password: '',
				lastname: '',
				firstname: '',
				authenticationError: 0
			}
		},
		methods: {
			signIn: function (event) {
				post_request_serv("users/sign_in",
					{
						email: this.usermail,
						password: this.password
					},
					(success, response) => {
						if (success) {
							set_token(response["data"].jwt);
							this.errorAuthentification = 0;
						} else
							this.errorAuthentification = 1;
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