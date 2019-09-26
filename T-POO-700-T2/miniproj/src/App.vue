<template>
	<div id="app">
		<navbar></navbar>
<!--		<Clock></Clock>-->
		<!--    <router-view></router-view>-->
	</div>
</template>

<script>
	//===============================================================
	// import
	//===============================================================
	import { get_cookie_token } from "./js/cookie.js";
	import Navbar from "./components/Navbar";
	import Clock from "./components/ClockManager/Clock";

	///===============================================================
	//
	//===============================================================
	export default {
		name: 'app',
		components: {
			Navbar,
			Clock
		},
		created() {
			this.getCookie()
		},
		methods: {
			getCookie: function (event) {
				if (get_cookie_token())
					console.info("cookie exist, no authentification required");
				else {
					console.info("cookie doesn't exist, authentification required");
				}
			}
		}
	}
</script>

<style>
</style>
