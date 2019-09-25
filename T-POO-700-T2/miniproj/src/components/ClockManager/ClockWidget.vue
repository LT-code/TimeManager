<template>
	<div class="switch col">
		<label for="clocker">
			<span v-if="!clockIn">I Am Not At Work</span>
			<span class="since-time" v-if="clockIn">I Am At Work Since {{ startDateTime }}</span>
			<input id="clocker" type="checkbox">
			<span class="lever" @click="clock"></span>
		</label>
	</div>
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

<style>
	label {
		color: #FFF6CB;
	}
	.switch label input[type=checkbox]:checked+.lever {
		background-color: #CCB43C;
	}
	.switch label input[type=checkbox]:checked+.lever:after {
		background-color: #FFF6CB;
	}
	.since-time {
		margin-top: 200px;
	}
</style>
