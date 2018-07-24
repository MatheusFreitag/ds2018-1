/**
* UsuarioController
*
* @description :: Server-side logic for managing Usuarios
* @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
*/
const util = require('util');

module.exports = {
  list:function(req,res){
    Usuario.query('SELECT * from c9.Usuario;', [], function(err, usuarios) {
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
    Usuario.query(`SELECT * from c9.Usuario WHERE CPF="${req.params.id}";`, ['u'], function(err, usuario) {
      if(err){
        res.send(500, {error: "Database error"});
      }
      res.view('usuario/about', {usuario: usuario[0]});
    })
  },
  edit: function(req,res){
    Usuario.query(`SELECT * from c9.Usuario WHERE cpf="${req.params.id}";`, [], function(err, usuario){
      if(err){
        res.send(500, {error: "Database error"});
      }

      res.view('usuario/edit', {usuario: usuario[0]});
    });
  },
  update: function(req,res){
    console.log(req.body);
    
    /* Quer mudar a foto */
		if (req.body.FotoPerfil != '') {
		  req.file('FotoPerfil').upload({ 
    		dirname: require('path').resolve(sails.config.appPath, 'assets/images/usuario'),
    		saveAs: req.body.CPF + '_' + "FotoPerfil." + (req.file('FotoPerfil')._files[0].stream.filename).substr(req.file('FotoPerfil')._files[0].stream.filename.length - 3)
	    	}, function (err, uploadedFiles) {
			  
			  console.log(uploadedFiles);
				var lista = uploadedFiles[0].fd.split('/');
        var tam = lista.length;
        var nomeFoto = lista[tam-1];
        
		    Usuario.query(`UPDATE c9.Usuario SET Nome="${req.body.Nome}", Nascimento="${req.body.Nascimento}", RG="${req.body.RG}", Email="${req.body.Email}", Senha="${req.body.Senha}", Endereco="${req.body.Endereco}", Telefone="${req.body.Telefone}",  Cidade="${req.body.Cidade}", Estado="${req.body.Estado}", Foto="${nomeFoto}" WHERE CPF="${req.body.CPF}";`, [], function(err, p){
          if(err){
            res.send(500, {error: "Database error"});
          }
          res.redirect('/usuario/list');
        });
		  })
		}
		else{
		  Usuario.query(`UPDATE c9.Usuario SET Nome="${req.body.Nome}", Nascimento="${req.body.Nascimento}", RG="${req.body.RG}", Email="${req.body.Email}", Senha="${req.body.Senha}", Endereco="${req.body.Endereco}", Telefone="${req.body.Telefone}",  Cidade="${req.body.Cidade}", Estado="${req.body.Estado}" WHERE CPF="${req.body.CPF}";`, [], function(err, p){
          if(err){
            res.send(500, {error: "Database error"});
          }
          res.redirect('/usuario/list');
      });
		}
    
  },
  delete:function(req,res){
    Usuario.query(`DELETE FROM banco.usuario WHERE cpf="${req.params.id}";`, [], function(err){
      if(err){
        res.send(500, {error: "Database error"});
      }
      res.redirect('usuario/list')
    });

    return false;
  },
  
  authenticate: function(req, res){
    console.log(req.body);
     Usuario.query(`SELECT * from c9.Usuario WHERE Email='${req.body.Email}';`, [], function(err, usuario) {
	        if(err) { 
	            res.send(500, {error: "Database error"});
	        }
	        
	        if(usuario[0] && usuario[0].Senha == req.body.Senha){
	            req.session.authenticated = 'ok';
	            req.session.cpf = usuario[0].CPF;
	            res.redirect('/automovel/list');
	        }
	        else{
	          console.log("no")
	            req.session.authenticated = 'no';
	            req.session.cpf = '';
	            res.redirect('/');
	        }
		});
  }
};

//cpf="${req.body.cpf}"
//, nascimento="${req.body.nascimento}", rg="${req.body.rg}", email="${req.body.email}", senha="${req.body.senha}", endereco="${req.body.endereco}", telefone="${req.body.telefone}", cidade="${req.body.cidade}", estado="${req.body.estado}"
