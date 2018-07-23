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
  //  	var AirBag = "0";
		// var ArCondicionado = "0";
		// var Alarme = "0";
		// var TravaEletrica = "0";
		// var Som = "0";
		// var VidroEletrico = "0";
		// var Blindado = "0";
		// var SensorRe = "0";
		// var CameraRe = "0";

		// if (req.body.AirBag) {AirBag = "1"}
		// if (req.body.ArCondicionado){ ArCondicionado = "1"}
		// if (req.body.Alarme){ Alarme = "1"}
		// if (req.body.TravaEletrica){ TravaEletrica = "1"}
		// if (req.body.Som){ Som = "1"}
		// if (req.body.VidroEletrico){ VidroEletrico = "1"}
		// if (req.body.Blindado){ Blindado = "1"}
		// if (req.body.SensorRe){ SensorRe = "1"}
		// if (req.body.CameraRe){ CameraRe = "1"}
		
		
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
		var ps,d;
		if(req.body.possuiSeguro && req.body.possuiSeguro=="on"){ps = "1";} else {ps = "0";};
		if(req.body.disponibilidade && req.body.disponibilidade=="on"){d = "1";} else {d = "0";};
		Automovel.query(`UPDATE c9.automovel SET modelo = "${req.body.modelo}", cor = "${req.body.cor}", chassi = "${req.body.chassi}", dataInicio = "${req.body.dataInicio}", dataFim = "${req.body.dataFim}", cidade = "${req.body.cidade}", estado = "${req.body.estado}", disponibilidade = "${d}", possuiSeguro = "${ps}", descricao = "${req.body.descricao}" WHERE placa="${req.body.placa}";`, [], function(err, p){
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

