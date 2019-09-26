<template>
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
		<router-link class="navbar-brand" to="/">Time Manager</router-link>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item nav-tab"><router-link class="nav-link" to="/">Profile</router-link></li>
				<li class="nav-item nav-tab"><router-link class="nav-link" to="/">Dashboard</router-link></li>
				<li class="nav-item nav-tab"><router-link class="nav-link" to="/">Team</router-link></li>
				<li class="nav-item nav-tab"><router-link class="nav-link" to="/">Working Times</router-link></li>
				<li class="nav-item"><ClockWidget class="widget"></ClockWidget></li>
				<li class="leftBorderDiv">.</li>
				<li class="nav-item nav-tab"><router-link class="nav-link" to="/">Log Out</router-link></li>
			</ul>
		</div>
	</nav>
</template>

<script>
	import ClockWidget from "./ClockManager/ClockWidget";

	export default {
		name: "Navbar",
		components: { ClockWidget }
	}
</script>

<style scoped>
	@import "../css/Navbar/navbar.css";

	nav {
		font-family: 'Nunito', sans-serif;
		background-color: #1E292C;
		padding: 0 0 0 0;
	}
</style>