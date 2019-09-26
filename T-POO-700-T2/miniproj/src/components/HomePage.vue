<template>
	<div>
		<navbar></navbar>

		<div id="navbar-marging">
		</div>

		<router-view />
	</div>
</template>

<script>
	//===============================================================
	// import
	//===============================================================
	import Navbar from "./Navbar";

	///===============================================================
	//
	//===============================================================
	export default {
		name: 'HomePage',
		components: {
			Navbar
		 },
		methods: {}
	}
</script>

<style>
#navbar-marging {
	margin-bottom: 65px;
}
</style>
