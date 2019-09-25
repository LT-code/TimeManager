<template>

	<nav class="blue-grey darken-4">
		<div class="nav-wrapper">
			<router-link class="brand-logo" to="/">Time Manager</router-link>
			<ul id="nav-mobile" class="right hide-on-med-and-down">
				<li><router-link class="nav-item" to="/">Profile</router-link></li>
				<li><router-link class="nav-item" to="/">Dashboard</router-link></li>
				<li><router-link class="nav-item" to="/">Team</router-link></li>
				<li><router-link class="nav-item" to="/">Working Times</router-link></li>
				<li><ClockWidget></ClockWidget></li>
				<li class="leftBorderDiv">.</li>
				<li><router-link class="nav-item" to="/">Log Out</router-link></li>
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
	nav {
		font-family: 'Nunito', sans-serif;
	}
	.nav-item {
		color: #FFD600;
	}
	.brand-logo {
		color: #FFD600;
		padding-left: 30px;
	}
	.brand-logo:hover, .nav-item:hover {
		color: #FFEA7F;
		text-decoration: none;
	}
	.leftBorderDiv
	{
		color: #998C4C;
		height: 35px;
		border-left: 1px solid #998C4C;
		margin-top: 15px;
		margin-left: 10px;
		margin-right: 10px;
	}
</style>