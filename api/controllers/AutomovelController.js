/**
 * AutomovelController
 *
 * @description :: Server-side logic for managing Automovels
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	list:function(req,res){
    	if(req.session.authenticated == 'ok'){
			console.log(req.param('cpf') != undefined);
			if(req.param('CPF') != undefined){
				Automovel.query(`SELECT * from c9.Automovel WHERE CPF="${req.param('CPF')}";`, [], function(err, automoveis) {
				    if(err) { 
				        res.send(500, {error: "Database error"});
				    }
				    res.view('automovel/list', {automoveis: automoveis});
				});
			}
			else{
				
				Automovel.query("SELECT * from c9.Automovel;", [], function(err, automoveis) {
				    if(err) { 
				        res.send(500, {error: "Database error"});
				    }
				    console.log(automoveis)
				    res.view('automovel/list', {automoveis: automoveis});
				});
			}
    	 }
    	 else{
    	 	res.redirect('/automovel/list');
    	 }
    },
    add: function(req,res){
	    res.view('automovel/add');
    },
    create: function(req,res){
    	if(req.session.authenticated == 'ok'){
    	
	    	req.file('FotoVeiculo').upload({ 
	    		dirname: require('path').resolve(sails.config.appPath, 'assets/images/automovel'),
	    		saveAs: req.body.Placa + '_' + "FotoVeiculo." + (req.file('FotoVeiculo')._files[0].stream.filename).substr(req.file('FotoVeiculo')._files[0].stream.filename.length - 3)
	    	}, function (err, uploadedFiles) {
			  console.log(uploadedFiles);
			  
				var lista = uploadedFiles[0].fd.split('/');
	            var tam = lista.length;
	            var nomeFoto = lista[tam-1];
			  
				Automovel.query(`INSERT INTO c9.Automovel (Placa, Marca, Modelo, Ano, Cambio, Combustivel, Direcao, PotenciaMotor, Tipo, Portas, Cor, Chassi, Disponibilidade, AirBag, ArCondicionado, Alarme, TravaEletrica, Som, VidroEletrico, Blindado, SensorRe, CameraRe, Titulo, Descricao, FotoVeiculoFrente, FotoVeiculoInterior, FotoVeiculoLateral, FotoDocumento, PossuiSeguro, Status, Cidade, Estado, Avaliacao, NumeroAvaliacoes, PrecoDiaria, CPF) VALUES("${req.body.Placa}", "${req.body.Marca}", "${req.body.Modelo}", "${req.body.Ano}", "${req.body.Cambio}", "${req.body.Combustivel}", "${req.body.Direcao}", "${req.body.Potencia}", "${req.body.tipoVeiculo}", "${req.body.numPortas}", "${req.body.corVeiculo}", "${req.body.Chassi}", "D", "${req.body.AirBag}", "${req.body.ArCondicionado}", "${req.body.Alarme}", "${req.body.travaEletrica}", "${req.body.Som}", "${req.body.vidroEletrico}", "${req.body.Blindado}", "${req.body.sensorRe}",  "${req.body.cameraRe}", "${req.body.Titulo}", "${req.body.Descricao}", "${nomeFoto}", "${nomeFoto}", "${nomeFoto}", "${nomeFoto}", "1", "Disponivel", "${req.body.cidadesEstado}", "${req.body.estadosBrasil}", "5", "0}", "${req.body.precoDiaria}", "${req.session.CPF}");`, [], function(err, automoveis){
			        if(err){
			            res.send(500, {error: "Database error"});
			    	}
					res.redirect('automovel/list');
				});
			});
    	}
    	else{
    		res.redirect('/');
    	}
    	
	
	},
	about: function(req,res){
		if(req.session.authenticated == 'ok'){
			Usuario.query(`SELECT * from c9.Automovel WHERE Placa="${req.params.id}";`, ['u'], function(err, automovel) {
				if(err){
		    		res.send(500, {error: "Database error"});
		    	}
		        res.view('automovel/about', {automovel: automovel[0]});
		    })
		}
		else{
			res.redirect('/usuario/add');
		}
	},
	edit: function(req,res){
		if(req.session.authenticated == 'ok'){
			console.log(`${req.params.id}`);
			Automovel.query(`SELECT * from c9.Automovel WHERE Placa="${req.params.id}";`, [], function(err, automovel){
				if(err){
		    		res.send(500, {error: "Database error"});
		    	}
		    	
		    	if(req.session.CPF == automovel[0].CPF){
		    		res.view('automovel/edit', {automovel: automovel[0]});
		    	}
		    	else{
		    		res.redirect('/automovel/add');
		    	}
			});
		}
		else{
			res.redirect('/usuario/add');
		}
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
		
		/* Quer mudar a foto */
		if (req.body.FotoVeiculo != '') {
			console.log('sim');
			req.file('FotoVeiculo').upload({ 
    		dirname: require('path').resolve(sails.config.appPath, 'assets/images/automovel'),
    		saveAs: req.body.Placa + '_' + "FotoVeiculo." + (req.file('FotoVeiculo')._files[0].stream.filename).substr(req.file('FotoVeiculo')._files[0].stream.filename.length - 3)
	    	}, function (err, uploadedFiles) {
			  console.log(uploadedFiles);
		  
				var lista = uploadedFiles[0].fd.split('/');
	            var tam = lista.length;
	            var nomeFoto = lista[tam-1];
	            
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
				FotoVeiculoFrente= "${nomeFoto}", \ 
				FotoVeiculoInterior= "${nomeFoto}", \ 
				FotoVeiculoLateral= "${nomeFoto}", \ 
				FotoDocumento= "${nomeFoto}", \ 
				Cidade= "${req.body.cidadesEstado}", \ 
				Estado= "${req.body.estadosBrasil}", \ 
				PrecoDiaria= "${req.body.precoDiaria}" \
				WHERE Placa="${req.body.Placa}";`, [], function(err, p){
				        if(err){
				            res.send(500, {error: "Database error"});
				        }
					    res.redirect('automovel/list');
				});
	    	});
			
		}
		/* Não quer mudar a foto */
		else{
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
			Cidade= "${req.body.cidadesEstado}", \ 
			Estado= "${req.body.estadosBrasil}", \ 
			PrecoDiaria= "${req.body.precoDiaria}" \
			WHERE Placa="${req.body.Placa}";`, [], function(err, p){
			        if(err){
			            res.send(500, {error: "Database error"});
			        }
				    res.redirect('automovel/list');
			});
		}
		
		
	},
	delete:function(req,res){
		if(req.session.authenticated == 'ok'){
		    Usuario.query(`DELETE FROM c9.Automovel WHERE (placa="${req.params.id}") AND (DataFinal < CURDATE());`, [], function(err){
		    	if(err){
		    		res.send(500, {error: "Database error"});
		    	}
		    	res.redirect('automovel/list')
		    });
		    
		    return false;
		}
		else{
			res.redirect('/usuario/add');
		}
	},
	
	reserva:function(req,res){
		
		console.log(req.body.DataInicio);
		console.log(req.body.DataFim);
		
		var dataInicioFormatada = req.body.DataInicio[6].concat(req.body.DataInicio[7]).concat(req.body.DataInicio[8]).concat(req.body.DataInicio[9]).concat('-').concat(req.body.DataInicio[3]).concat(req.body.DataInicio[4]).concat('-').concat(req.body.DataInicio[0]).concat(req.body.DataInicio[1]);
		var dataFimFormatada = req.body.DataFim[6].concat(req.body.DataFim[7]).concat(req.body.DataFim[8]).concat(req.body.DataFim[9]).concat('-').concat(req.body.DataFim[3]).concat(req.body.DataFim[4]).concat('-').concat(req.body.DataFim[0]).concat(req.body.DataFim[1]);

		if(req.params.id != undefined){
				Automovel.query(`SELECT * from c9.Automovel WHERE Placa="${req.params.id}";`, [], function(err, automoveis) {
				    if(err) { 
				        res.send(500, {error: "Database error"});
				    }
				    Automovel.query(`INSERT INTO c9.Aluguel (DataInicio, DataFim, CPF, Placa, FotoVeiculoFrente, Titulo, CPFDono) VALUES ("${dataInicioFormatada}", "${dataFimFormatada}", "${req.session.CPF}", "${automoveis[0].Placa}", "${automoveis[0].FotoVeiculoFrente}", "${automoveis[0].Titulo}", "${automoveis[0].CPF}");`, [], function(err){
						if(err){
							console.log(err);
							res.send(500, {error: "Database error"});
						}
					res.redirect('/usuario/listaAlugueis');
					});
				});
				    
		}
	}
};