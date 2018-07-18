$(function() {
	var Main = {
		init: function() {
			Main.ref.init.call();
			console.log('esta chamando!!!')
		},
		vars: {
			dropzoneArea: $('.dragdrop-area'),
			placa: $('#inputPlaca')
		},
		ref: {
			init: function () {
				Main.ref.dropImage.call();
			},
			dropImage: function() {
				Main.vars.dropzoneArea.dropzone({
					url: "./users/cars/" + Main.vars.placa,

				});
			}
		}
	}
	Main.init.call();
});