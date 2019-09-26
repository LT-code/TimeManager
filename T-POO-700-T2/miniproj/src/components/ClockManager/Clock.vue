<template>
	<div class="materialPicker">
		<div class="timeContainer first">
			<div class="waves-effect waves-light btn pickerButton btnUp">
				<i class="mdi-hardware-keyboard-arrow-up"></i>
			</div>
			<div class="Number">
				00
			</div>
			<div class="waves-effect waves-light btn pickerButton btnDown">
				<i class="mdi-hardware-keyboard-arrow-down"></i>
			</div>
		</div>

		<!-- Same structure as above -->

		<div class="timeContainer second">
			<div class="waves-effect waves-light btn pickerButton btnUp">
				<i class="mdi-hardware-keyboard-arrow-up"></i>
			</div>
			<div class="Number">
				00
			</div>
			<div class="waves-effect waves-light btn pickerButton btnDown">
				<i class="mdi-hardware-keyboard-arrow-down"></i>
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		name: "Clock"
	}
</script>

<style scoped>
	.materialPicker{
		width: 18rem;
	}

	.Number{
		border: none;
		text-align: center;
		font-size: 6.1rem;
		width: 8.4rem;
	}

	.pickerButton{
		width:100%;
	}

	.first{
		float:left;
	}
	.second{
		float:right;
	}
</style>