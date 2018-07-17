$(document).ready(function () {
	$.getJSON('../datasets/marcas.json', function (data) {

		var options = '<option value="">Escolha uma marca</option>';	

		$.each(data, function (key, val) {
			options += '<option value="' + val.id + '">' + val.fipe_name + '</option>';
		});	

		$("#inputMarca").html(options);				

		$("#inputMarca").change(function () {				

			var options_modelo = '';
			var id = $("#inputMarca option:selected").val();	
			console.log(id);
			var url = 'http://fipeapi.appspot.com/api/1/carros/veiculos/' + id + '.json';

			$("#inputModelo").html('');//Zera o campo modelo sob qualquer alteração;

			$.getJSON(url, function(modelo) {
				$.each(modelo, function (key, val) {
					options_modelo += '<option value="' + val.name + '">' + val.name + '</option>';
				});	
				$("#inputModelo").html(options_modelo);
			});


		}).change();		

	});	

});