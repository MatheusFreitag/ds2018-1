/**
 * AutomovelController
 *
 * @description :: Server-side logic for managing Automovels
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	list:function(req,res){
	   Automovel.query('SELECT * from c9.automovel;', [], function(err, automoveis) {
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
    	var ps,d;
		if(req.body.possuiSeguro && req.body.possuiSeguro=="on"){ps = "1";} else {ps = "0";};
		if(req.body.disponibilidade && req.body.disponibilidade=="on"){d = "1";} else {d = "0";};
		Automovel.query(`INSERT INTO c9.automovel (placa, modelo, cor, chassi, dataInicio, dataFim, cidade, estado, disponibilidade, possuiSeguro, descricao) VALUES( "${req.body.placa}", "${req.body.modelo}", "${req.body.cor}", "${req.body.chassi}", "${req.body.dataInicio}", "${req.body.dataFim}", "${req.body.cidade}", "${req.body.estado}", "${d}", "${ps}", "${req.body.descricao}");`, [], function(err, usuarios){
	        if(err){
	            res.send(500, {error: "Database error"});
	        }
	        res.redirect('automovel/list');
	    });
	},
	about: function(req,res){
		Usuario.query(`SELECT * from c9.automovel WHERE placa="${req.params.id}";`, ['u'], function(err, automovel) {
			if(err){
	    		res.send(500, {error: "Database error"});
	    	}
	        res.view('automovel/about', {automovel: automovel[0]});
	    })
	},
	edit: function(req,res){
		Automovel.query(`SELECT * from c9.automovel WHERE placa="${req.params.id}";`, [], function(err, automovel){
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

