<template>
	<body>
		<!-- Search block -->
		<div class="block">
			<h2>Où ?</h2>
			<select id="mySelect" v-model="city">
			  <option selected="selected">Toulouse</option>
			  <option>Lyon</option>
			  <option>Paris</option>
				<option>Pedrita</option>
			</select>
			<br/>
			<br/>
			<button v-on:click="refreshCurrentWeather()">Météo actuelle</button>
			<button v-on:click="refreshHistoricalWeather()">Historique des températures maximales</button>
		</div>
		<br/>

		<!-- Current Weather block -->
		<div class="block" >
			<div v-if="error == 0">
				<h2>Météo Actuelle à {{ city }}</h2>
				<span>Temperature : {{ temp }}°C</span>
				<br/>	<br/>
				<span>Date : {{ dt }}</span>
			</div>
			<div  v-else>
				<h2 id="title_error">Impossible de récupérer la météo actuelle à {{ city }}</h2>
			</div>
		</div>

		<!-- Last 7 days Weather block
		<div>
			<chart -maker :params="YOUR_CHART_PARAMS" v-if="YOUR_BOOLEAN_VARIABLE_NAME" >
				<tr v-for="YOUR_FOR_LOOP" :key="YOUR_UNIQUE_ID" >

				</tr>
			</chart -maker>
		</div>
 		-->
	</body>
</template>

<script>
	//=========================================================
	// Date Gestion
	var moment = require('moment');
	var date_time = moment().format('DD MMMM YYYY');
	var date_hist = moment();

	//=========================================================
	// create array of 7 last days
	var historical_date = [];
	var historical_date_str = "";
	var tmpdate;
	for(var i = 1; i < 7; i++) {
		tmpdate = date_hist.subtract(i, 'days').format("YYYY-MM-DD");
		historical_date.push(tmpdate);
		historical_date_str += tmpdate;
		if(i < 6)
			historical_date_str += ";"
	}

	//=========================================================
	// create array of 7 last days
	var historical_date = [];
	var historical_date_str = "";
	var tmpdate;
	for(var i = 1; i < 7; i++) {
		tmpdate = date_hist.subtract(i, 'days').format("YYYY-MM-DD");
		historical_date.push(tmpdate);
		historical_date_str += tmpdate;
		if(i < 6)
			historical_date_str += ";"
	}

	//=========================================================
	// Wheater Gestion
	import  axios  from 'axios'
	import ChartMaker from 'vue-chartmaker'

	//=========================================================
	// API
	export default {
		name: 'CurrentWeather',
		components: {
			ChartMaker
		},
		data() {
			return {
				temp: 0,
				dt: date_time,
				city: '',
				error: 1
			};
		},
		methods: {
			//=========================================================
			// get the weather
	    refreshCurrentWeather: function (event) {
				var e = document.getElementById("mySelect");

				if(e.selectedIndex >= 0)
					// get information from the api
					axios.get('http://api.weatherstack.com/current?access_key=47487d9504a452ab3345aab58f098459&units=m&query=' + e.value)
					.then ((response) => {
						// check http status
						if(response.status == 200) {
							// check if the api got wrong or not
							if(response.data["success"] == false)
								this.error = 1;
							else {
								this.temp = response.data["current"]["temperature"];
								this.error = 0;
							}
						}
						else
							this.error = 1;
					})
	    },
			//=========================================================
			// get the weather for the las 7 days
			refreshHistoricalWeather: function (event) {
				var e = document.getElementById("mySelect");

				if(e.selectedIndex >= 0) {
					// get information from the api
					axios.get('http://api.weatherstack.com/historical?access_key=47487d9504a452ab3345aab58f098459&query=' + e.value + '&historical_date=' + historical_date_str)
					.then ((response) => {
						console.log(response.data);
					})
				}
			}
		}
	}
</script>

<style>
	.block {
		text-align: center;
		vertical-align: middle;
		display: table-cell;
		background-color: #B4B4B4;
		height: 190px;
		width: 1000px;
		margin: 0 auto;
	}

	#title_error {
		color: red;
	}
</style>
