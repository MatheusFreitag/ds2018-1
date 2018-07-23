/**
 * AutomovelController
 *
 * @description :: Server-side logic for managing Automovels
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	list:function(req,res){
	   Automovel.query('SELECT * from c9.Automovel;', [], function(err, automoveis) {
	        if(err) { 
	            res.send(500, {error: "Database error"});
	        }
	        res.view('automovel/list', {automoveis: automoveis});
		});
    },
    add: function(req,res){
	    res.view('automovel/add');
    },
    create: function(req,res){
    	console.log(req.body);
		
		Automovel.query(`INSERT INTO c9.Automovel (Placa, Marca, Modelo, Ano, Cambio, Combustivel, Direcao, PotenciaMotor, Tipo, Portas, Cor, Chassi, Disponibilidade, AirBag, ArCondicionado, Alarme, TravaEletrica, Som, VidroEletrico, Blindado, SensorRe, CameraRe, Titulo, Descricao, FotoVeiculoFrente, FotoVeiculoInterior, FotoVeiculoLateral, FotoDocumento, PossuiSeguro, Status, Cidade, Estado, Avaliacao, NumeroAvaliacoes, PrecoDiaria, CPF) VALUES("${req.body.Placa}", "${req.body.Marca}", "${req.body.Modelo}", "${req.body.Ano}", "${req.body.Cambio}", "${req.body.Combustivel}", "${req.body.Direcao}", "${req.body.Potencia}", "${req.body.tipoVeiculo}", "${req.body.numPortas}", "${req.body.corVeiculo}", "${req.body.Chassi}", "D", "${req.body.AirBag}", "${req.body.ArCondicionado}", "${req.body.Alarme}", "${req.body.travaEletrica}", "${req.body.Som}", "${req.body.vidroEletrico}", "${req.body.Blindado}", "${req.body.sensorRe}",  "${req.body.cameraRe}", "${req.body.Titulo}", "${req.body.Descricao}", "images/automovel/fiatUno.jpg", "images/automovel/fiatUno.jpg", "images/automovel/fiatUno.jpg", "images/automovel/fiatUno.jpg", "1", "Disponivel", "${req.body.cidadesEstado}", "${req.body.estadosBrasil}", "5", "0}", "${req.body.precoDiaria}", "02840193719");`, [], function(err, usuarios){
	        if(err){
	            res.send(500, {error: "Database error"});
	    	}
	        res.redirect('automovel/list');
	    });
	},
	about: function(req,res){
		Usuario.query(`SELECT * from c9.Automovel WHERE Placa="${req.params.id}";`, ['u'], function(err, automovel) {
			if(err){
	    		res.send(500, {error: "Database error"});
	    	}
	        res.view('automovel/about', {automovel: automovel[0]});
	    })
	},
	edit: function(req,res){
		console.log(`${req.params.id}`);
		Automovel.query(`SELECT * from c9.Automovel WHERE Placa="${req.params.id}";`, [], function(err, automovel){
			if(err){
	    		res.send(500, {error: "Database error"});
	    	}
	    	
	    	res.view('automovel/edit', {automovel: automovel[0]});
		});
	},
	update: function(req,res){
		console.log(req.body);
		
		var AirBag, ArCondicionado, Alarme, TravaEletrica, Som, VidroEletrico, Blindado, SensorRe, CameraRe;
		
		if (req.body.AirBag && req.body.AirBag == 'on') {AirBag = 1} else { AirBag = 0}
		if (req.body.ArCondicionado && req.body.ArCondicionado == 'on') {ArCondicionado = 1} else { ArCondicionado = 0}
		if (req.body.Alarme && req.body.Alarme == 'on') {Alarme = 1} else { Alarme = 0}
		if (req.body.travaEletrica && req.body.travaEletrica == 'on') {TravaEletrica = 1} else { TravaEletrica = 0}
		if (req.body.Som && req.body.Som == 'on') {Som = 1} else { Som = 0}
		if (req.body.vidroEletrico && req.body.vidroEletrico == 'on') {VidroEletrico = 1} else { VidroEletrico = 0}
		if (req.body.Blindado && req.body.Blindado == 'on') {Blindado = 1} else { Blindado = 0}
		if (req.body.sensorRe && req.body.sensorRe == 'on') {SensorRe = 1} else { SensorRe = 0}
		if (req.body.cameraRe && req.body.cameraRe == 'on') {CameraRe = 1} else { CameraRe = 0}
		
		Automovel.query(`UPDATE c9.Automovel SET \
		Marca= "${req.body.Marca}", \ 
		Modelo= "${req.body.Modelo}", \ 
		Ano= "${req.body.Ano}", \ 
		Cambio= "${req.body.Cambio}", \ 
		Combustivel= "${req.body.Combustivel}", \ 
		Direcao= "${req.body.Direcao}", \ 
		PotenciaMotor= "${req.body.Potencia}", \ 
		Tipo = "${req.body.tipoVeiculo }", \ 
		Portas= "${req.body.numPortas}", \ 
		Cor= "${req.body.corVeiculo}", \ 
		Chassi= "${req.body.Chassi}", \ 
		AirBag= "${AirBag}", \ 
		ArCondicionado= "${ArCondicionado}", \ 
		Alarme= "${Alarme}", \ 
		TravaEletrica= "${TravaEletrica}", \ 
		Som= "${Som}", \ 
		VidroEletrico= "${VidroEletrico}", \ 
		Blindado= "${Blindado}", \ 
		SensorRe= "${SensorRe}", \ 
		CameraRe= "${CameraRe}", \ 
		Titulo= "${req.body.Titulo}", \ 
		Descricao= "${req.body.Descricao}", \ 
		FotoVeiculoFrente= "images/automovel/fiatUno.jpg", \ 
		FotoVeiculoInterior= "images/automovel/fiatUno.jpg", \ 
		FotoVeiculoLateral= "images/automovel/fiatUno.jpg", \ 
		FotoDocumento= "images/automovel/fiatUno.jpg", \ 
		Cidade= "${req.body.cidadesEstado}", \ 
		Estado= "${req.body.estadosBrasil}", \ 
		PrecoDiaria= "${req.body.precoDiaria}" \
		WHERE Placa="${req.body.Placa}";`, [], function(err, p){
		        if(err){
		            res.send(500, {error: "Database error"});
		        }
			    res.redirect('automovel/list');
		});
	},
	delete:function(req,res){
	    Usuario.query(`DELETE FROM c9.automovel WHERE placa="${req.params.id}";`, [], function(err){
	    	if(err){
	    		res.send(500, {error: "Database error"});
	    	}
	    	res.redirect('automovel/list')
	    });
	    
	    return false;
	}
};

