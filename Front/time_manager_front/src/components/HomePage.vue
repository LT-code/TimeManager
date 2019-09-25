<template>
	<div>
		<h1>Welcome to Gotham's City Time Management Application !</h1>
		<h2>If you already have an account, please <router-link to="/login">login</router-link></h2>
		<h2>Else you can create one <router-link to="/register">here...</router-link></h2>
	</div>
</template>

<script>
	export default {
		name: "Welcome"
	}
</script>

<style scoped>

</style>