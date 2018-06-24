/**
 * UsuarioController
 *
 * @description :: Server-side logic for managing Usuarios
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */
const util = require('util');

module.exports = {
	list:function(req,res){
	    Usuario.query('SELECT * from c9.usuario;', [], function(err, usuarios) {
	        if(err) { 
	            res.send(500, {error: "Database error"});
	        }
	        res.view('usuario/list', {usuarios: usuarios});
		});
    },
    add: function(req,res){
	    res.view('usuario/add');
    },
    create: function(req,res){
		Usuario.query(`INSERT INTO c9.usuario (cpf, nome, nascimento, rg, email, senha, endereco, telefone, cidade, estado) VALUES( "${req.body.cpf}", "${req.body.nome}", "${req.body.nascimento}", "${req.body.rg}", "${req.body.email}", "${req.body.senha}", "${req.body.endereco}", "${req.body.telefone}", "${req.body.cidade}", "${req.body.estado}");`, [], function(err, usuarios){
	        
	        if(err){
	            res.send(500, {error: "Database error"});
	        }
	        res.redirect('usuario/list');
	    });
	},
	about: function(req,res){
		Usuario.query(`SELECT * from c9.usuario WHERE cpf="${req.params.id}";`, ['u'], function(err, usuario) {
			if(err){
	    		res.send(500, {error: "Database error"});
	    	}
	        res.view('usuario/about', {usuario: usuario[0]});
	    })
	},
	edit: function(req,res){
		Usuario.query(`SELECT * from c9.usuario WHERE cpf="${req.params.id}";`, [], function(err, usuario){
			if(err){
	    		res.send(500, {error: "Database error"});
	    	}
	    	
	    	res.view('usuario/edit', {usuario: usuario[0]});
		});
	},
	update: function(req,res){
	    console.log(`${req.body.nascimento}`);
		Usuario.query(`UPDATE c9.usuario SET nome="${req.body.nome}", nascimento="${req.body.nascimento}", rg="${req.body.rg}", email="${req.body.email}", senha="${req.body.senha}", endereco="${req.body.endereco}", telefone="${req.body.telefone}", cidade="${req.body.cidade}", estado="${req.body.estado}" WHERE cpf="${req.body.cpf}";`, [], function(err, p){
		        if(err){
		            res.send(500, {error: "Database error"});
		        }
			    res.redirect('/usuario/list');
		});
	},
	delete:function(req,res){
	    Usuario.query(`DELETE FROM c9.usuario WHERE cpf="${req.params.id}";`, [], function(err){
	    	if(err){
	    		res.send(500, {error: "Database error"});
	    	}
	    	res.redirect('usuario/list')
	    });
	    
	    return false;
	}
};

//cpf="${req.body.cpf}"
//, nascimento="${req.body.nascimento}", rg="${req.body.rg}", email="${req.body.email}", senha="${req.body.senha}", endereco="${req.body.endereco}", telefone="${req.body.telefone}", cidade="${req.body.cidade}", estado="${req.body.estado}" 