<template>
	<div>
		<span class="since-time" v-if="!clockIn">I Am Not At Work</span>
		<span class="since-time" v-if="clockIn">I Am At Work Since {{ startDateTime }}</span>
		<label class="switch">
			<input type="checkbox">
			<span class="slider round" @click="clock"></span>
		</label>
	</div>

	<!--
	<div class="switch col">
		<input type="checkbox" checked data-toggle="toggle" data-onstyle="primary">
		<label for="clocker">
			<span v-if="!clockIn">I Am Not At Work</span>
			<span class="since-time" v-if="clockIn">I Am At Work Since {{ startDateTime }}</span>
			<input id="clocker" type="checkbox">
			<span class="lever" @click="clock"></span>
		</label>
	</div>
-->
</template>

<script>
	import moment from 'moment'

	export default {
		name: 'ClockManager',
		components: {},
		data() {
			return {
				startDateTime: null,
				clockIn: false
			};
		},
		methods: {
			refresh: function () {
			},

			clock: function () {
				this.clockIn = !this.clockIn;
				this.startDateTime = moment().locale('fr').format('HH:mm');
			}
		}
	}
</script>

<style scoped>
	@import "../../css/Navbar/clockWidget.css";

</style>
