<template>
	<div id="app">
		<router-view></router-view>
	</div>
</template>

<script>
	//===============================================================
	// import
	//===============================================================
	import {
						get_cookie_token
					} from "./js/cookie.js";

	///===============================================================
	//
	//===============================================================
	export default {
		name: 'app',
		components: {},
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
