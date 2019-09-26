<template>
	<div>
		<navbar></navbar>
		<br>
		coucou
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

</style>
