/**
* UsuarioController
*
* @description :: Server-side logic for managing Usuarios
* @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
*/
const util = require('util');

module.exports = {
  list: function(req,res){
      Usuario.query('SELECT * from c9.Usuario;', [], function(err, usuarios) {
        if(err) {
          res.send(500, {error: "Database error"});
        }
        res.view('usuario/list', {usuarios: usuarios});
      });
  },

  listaAlugueis: function(req,res){
    if(req.session.authenticated == 'ok'){
      Usuario.query(`SELECT * from c9.Aluguel WHERE (CPF="${req.session.CPF}") AND (DataFim >= CURDATE());`, [], function(err, alugueis){
        if(err){
          res.send(500, {error: "Database Error"});
        }

      res.view('usuario/alugueis', {alugueis: alugueis});
      });
    }
    else{
      res.redirect('/usuario/add');
    }
  },

  listaConcluidos: function(req,res){
    if(req.session.authenticated == 'ok'){
      Usuario.query(`SELECT * from c9.Aluguel WHERE (CPF="${req.session.CPF}") AND (DataFim < CURDATE());`, [], function(err, alugueis){
        if(err){
          res.send(500, {error: "Database Error"});
        }

      res.view('usuario/concluidos', {alugueis: alugueis});
      });
    }
    else{
      res.redirect('/usuario/add');
    }
  },

  avaliacao: function(req, res){
    if(req.session.authenticated == 'ok'){
			console.log(req.param('idAluguel') != undefined);
			if(req.param('idAluguel') != undefined){

			  res.view('usuario/avaliacao', {idAluguel: req.param('idAluguel')});
			}
    	}
    	else{
    		res.redirect('/usuario/add');
    	}
  },

  avaliacaoConcluida: function(req, res){
    if(req.session.authenticated == 'ok'){

    }
    else{
      res.redirect('/usuario/add');
    }
  },


  add: function(req,res){
    res.view('usuario/add');
  },

  create: function(req,res){
    console.log(req.body);
    req.file('FotoPerfil').upload({
    		dirname: require('path').resolve(sails.config.appPath, 'assets/images/usuario'),
    		saveAs: req.body.CPF + '_' + "FotoPerfil." + (req.file('FotoPerfil')._files[0].stream.filename).substr(req.file('FotoPerfil')._files[0].stream.filename.length - 3)
    	}, function (err, uploadedFiles) {
		      console.log(uploadedFiles);

			      var lista = uploadedFiles[0].fd.split('/');
            var tam = lista.length;
            var nomeFoto = lista[tam-1];
            Usuario.query(`INSERT INTO c9.Usuario (CPF,Nome, Nascimento,RG,Email,Senha,Endereco,Telefone,Cidade,Estado,Sexo, Foto) VALUES("${req.body.CPF}","${req.body.Nome}","${req.body.Nascimento}","${req.body.RG}","${req.body.Email}","${req.body.Senha}","${req.body.Endereco}","${req.body.Telefone}","${req.body.Cidade}","${req.body.Estado}","${req.body.Sexo}", "${nomeFoto}");`, [], function(err, usuarios){
                if(err){
                  res.send(500, {error: "Database error"});
                }
                res.redirect('/usuario/list');
              });
    	});
  },

  about: function(req,res){
    if(req.session.authenticated == 'ok'){
      Usuario.query(`SELECT * from c9.Usuario WHERE CPF="${req.params.id}";`, ['u'], function(err, usuario) {
        if(err){
          res.send(500, {error: "Database error"});
        }
        res.view('usuario/about', {usuario: usuario[0]});
      })
    }
    else{
      res.redirect('/usuario/add');
    }
  },

  edit: function(req,res){
    if(req.session.authenticated == 'ok'){
      Usuario.query(`SELECT * from c9.Usuario WHERE cpf="${req.params.id}";`, [], function(err, usuario){
        if(err){
          res.send(500, {error: "Database error"});
        }

        if(req.session.CPF == usuario[0].CPF){
          res.view('usuario/edit', {usuario: usuario[0]});
        }
        else{
          res.view('usuario/about', {usuario: usuario[0]});
        }
      });
    }
    else{
      res.redirect('/usuario/add');
    }

  },

  update: function(req,res){
    console.log(req.body);

    /* Quer mudar a foto */
		if (req.body.FotoPerfil != '') {
		  req.file('FotoPerfil').upload({
    		dirname: require('path').resolve(sails.config.appPath, 'assets/images/usuario'),
    		saveAs: req.body.Nome + '_' + "FotoPerfil." + (req.file('FotoPerfil')._files[0].stream.filename).substr(req.file('FotoPerfil')._files[0].stream.filename.length - 3)
	    	}, function (err, uploadedFiles) {

			  console.log(uploadedFiles);
				var lista = uploadedFiles[0].fd.split('/');
        var tam = lista.length;
        var nomeFoto = lista[tam-1];

		    Usuario.query(`UPDATE c9.Usuario SET Email="${req.body.Email}", Senha="${req.body.Senha}", Endereco="${req.body.Endereco}", Telefone="${req.body.Telefone}",  Cidade="${req.body.Cidade}", Estado="${req.body.Estado}", Foto="${nomeFoto}" WHERE CPF="${req.session.CPF}";`, [], function(err, p){
          if(err){
            res.send(500, {error: "Database error"});
          }
          res.redirect('/usuario/list');
        });
		  })
		}
		else{
		  Usuario.query(`UPDATE c9.Usuario SET Email="${req.body.Email}", Senha="${req.body.Senha}", Endereco="${req.body.Endereco}", Telefone="${req.body.Telefone}",  Cidade="${req.body.Cidade}", Estado="${req.body.Estado}" WHERE CPF="${req.session.CPF}";`, [], function(err, p){
          if(err){
            res.send(500, {error: "Database error"});
          }
          res.redirect('/usuario/list/');
      });
		}
  },
  delete:function(req,res){
    if(req.session.authenticated == 'ok'){
      Usuario.query(`DELETE FROM c9.Usuario WHERE CPF="${req.params.id}";`, [], function(err){
        if(err){
          res.send(500, {error: "Database error"});
        }
        res.redirect('usuario/list')
      });

      return false;
    }
    else{
      res.redirect('/usuario/add');
    }
  },

  authenticate: function(req, res){
     Usuario.query(`SELECT * from c9.Usuario WHERE Email='${req.body.Email}';`, [], function(err, usuario) {
	        if(err) {
	            res.send(500, {error: "Database error"});
	        }

	        if(usuario[0] && usuario[0].Senha == req.body.Senha){
	            req.session.authenticated = 'ok';
	            req.session.CPF = usuario[0].CPF;
	            req.session.Nome = usuario[0].Nome;
	            console.log(req.session);
	            res.redirect('/automovel/list');
	        }
	        else{
	          console.log("no")
	            req.session.authenticated = 'no';
	            req.session.CPF = '';
	            req.session.Nome = '';
	            res.redirect('/');
	        }
		});
  },

  logout: function(req,res){
    req.session.authenticated = 'no';
    req.session.CPF = '';
    res.redirect('/');
  }
};
