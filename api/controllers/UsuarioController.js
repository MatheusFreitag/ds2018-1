/**
* UsuarioController
*
* @description :: Server-side logic for managing Usuarios
* @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
*/
const util = require('util');

module.exports = {
  list: function(req,res){
    
      if(req.params.id == "p"){
        if(req.body.Nome != undefined){
          Usuario.query(`SELECT * from c9.Usuario WHERE (Nome="${req.body.Nome}")`, [], function(err, usuarios){
          if(err){
            res.send(500, {error: "Database Error"});
          }
          res.view('usuario/list', {usuarios: usuarios});
        });
       }
      }
      
      
      else{
          Usuario.query('SELECT * from c9.Usuario;', [], function(err, usuarios) {
          if(err) {
            res.send(500, {error: "Database error"});
          }
          res.view('usuario/list', {usuarios: usuarios});
        });
      }
      
  },

  listaAlugueis: function(req,res){
    console.log("chegou");
    if(req.session.authenticated == 'ok'){
      console.log(req.session.CPF);
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
      if(req.params.id != undefined){
        console.log(req.body);
        
        var notaNovaAutomovel = req.body.carro;
        var notaNovaUsuario = (req.body.dialogo + req.body.verac + req.body.preco + req.body.comproment)/4;
        var CPFBusca;
        var PlacaBusca;
        
        var segundaQ = function(CPFBusca, PlacaBusca){
          Usuario.query(`SELECT * FROM c9.Usuario WHERE CPF="${CPFBusca}"`, [], function(err2, usuario){
            
            console.log(CPFBusca);
            console.log(PlacaBusca);
            var notaUsuarioAntiga = usuario[0].Avaliacao;
            var numeroAvaliacoesUsuarioAntiga = usuario[0].NumeroAvaliacoes;
            var numeroAvaliacoesUsuarioNova = numeroAvaliacoesUsuarioAntiga+1;
            var notaUsuarioFinal = ((notaUsuarioAntiga*numeroAvaliacoesUsuarioAntiga)+(notaNovaUsuario))/numeroAvaliacoesUsuarioNova;
            Usuario.query(`UPDATE c9.Usuario SET Avaliacao="${notaUsuarioFinal}", NumeroAvaliacoes="${numeroAvaliacoesUsuarioNova}" WHERE CPF="${CPFBusca}"`, [], function(err3){});
            terceiraQ(PlacaBusca);
          });
        }
        
        var terceiraQ = function(PlacaBusca) {
        Usuario.query(`SELECT * FROM c9.Automovel WHERE Placa="${PlacaBusca}"`, [], function(err4, automovel){
            
            console.log(CPFBusca);
            console.log(PlacaBusca);
            var notaAutomovelAntiga = automovel[0].Avaliacao;
            var numeroAvaliacoesAutomovelAntiga = automovel[0].NumeroAvaliacoes;
            var numeroAvaliacoesAutomovelNova = numeroAvaliacoesAutomovelAntiga+1;
            var notaAutomovelFinal = ((notaAutomovelAntiga*numeroAvaliacoesAutomovelAntiga)+(notaNovaAutomovel))/numeroAvaliacoesAutomovelNova;
            Usuario.query(`UPDATE c9.Automovel SET Avaliacao="${notaAutomovelFinal}", NumeroAvaliacoes="${numeroAvaliacoesAutomovelNova}" WHERE Placa="${PlacaBusca}"`, [], function(err5){});
            quartaQ();
        });
        }
        
        var quartaQ = function(){
          Usuario.query(`DELETE FROM c9.Aluguel WHERE idAluguel="${req.params.id}"`, [], function(err6, aluguel){
            res.redirect('/usuario/listaConcluidos');
          })
        }
        
        Usuario.query(`SELECT * FROM c9.Aluguel WHERE idAluguel="${req.params.id}"`, [], function(err, aluguel){
          CPFBusca = aluguel[0].CPFDono;
          PlacaBusca = aluguel[0].Placa;
          console.log(CPFBusca);
          console.log(PlacaBusca);
          segundaQ(CPFBusca, PlacaBusca);
        });

        
       
        
        
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
                res.redirect('/automovel/list');
              });
    	});
  },

  about: function(req,res){
    console.log(req.params.id);
    if(req.session.authenticated == 'ok'){
      Usuario.query(`SELECT * from c9.Usuario WHERE CPF="${req.params.id}";`, ['u'], function(err, usuario) {
        if(err){
          res.send(500, {error: "Database error"});
        }
        if(req.session.CPF == usuario[0].CPF){
          res.view('usuario/about2', {usuario: usuario[0]});
        }
        else{
          res.view('usuario/about', {usuario: usuario[0]});
        }
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
    		saveAs: req.session.CPF + '_' + "FotoPerfil." + (req.file('FotoPerfil')._files[0].stream.filename).substr(req.file('FotoPerfil')._files[0].stream.filename.length - 3)
	    	}, function (err, uploadedFiles) {

			  console.log(uploadedFiles);
				var lista = uploadedFiles[0].fd.split('/');
        var tam = lista.length;
        var nomeFoto = lista[tam-1];

		    Usuario.query(`UPDATE c9.Usuario SET Nome = "${req.body.Nome}", Email="${req.body.Email}", Senha="${req.body.Senha}", Endereco="${req.body.Endereco}", Telefone="${req.body.Telefone}",  Cidade="${req.body.Cidade}", Estado="${req.body.Estado}", Foto="${nomeFoto}", Senha = "${req.body.Senha}" WHERE CPF="${req.session.CPF}";`, [], function(err, p){
          if(err){
            res.send(500, {error: "Database error"});
          }
          res.redirect("usuario/list");
        });
		  })
		}
		else{
		  Usuario.query(`UPDATE c9.Usuario SET Nome = "${req.body.Nome}", Email="${req.body.Email}", Senha="${req.body.Senha}", Endereco="${req.body.Endereco}", Telefone="${req.body.Telefone}",  Cidade="${req.body.Cidade}", Estado="${req.body.Estado}", Senha = "${req.body.Senha}" WHERE CPF="${req.session.CPF}";`, [], function(err, p){
          if(err){
            res.send(500, {error: "Database error"});
          }
          res.redirect("usuario/list");
      });
		}
  },
  delete:function(req,res){
    if(req.session.authenticated == 'ok'){
      Usuario.query(`DELETE FROM c9.Usuario WHERE CPF="${req.params.id}";`, [], function(err){
        if(err){
          res.send(500, {error: "Database error"});
        }
        res.redirect('/usuario/logout');
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
