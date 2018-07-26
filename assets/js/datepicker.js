$(document).ready(function(){
	var date_input = $('input[class="form-control date"]'); //our date input has the name "date"

//	var first_cal = $('input[id="inicio-reserva"]');
//	var second_cal = $('input[id="fim-reserva"]');
	
	date_input.datepicker({
		format: 'dd/mm/yyyy',
		language: "pt-BR",
		startDate: new Date(),
		orientation: 'top'

	})
	
});