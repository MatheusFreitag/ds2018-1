/**
* UsuarioController
*
* @description :: Server-side logic for managing Usuarios
* @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
*/
const util = require('util');

module.exports = {
  list:function(req,res){
    Usuario.query('SELECT * from banco.usuario;', [], function(err, usuarios) {
      if(err) {
        res.send(500, {error: "Database error"});
      }
      console.log(usuarios);

      res.view('usuario/list', {usuarios: usuarios});
    });
  },
  add: function(req,res){
    res.view('usuario/add');
  },
  create: function(req,res){
    res.redirect('/');
    Usuario.query(`INSERT INTO banco.usuario (cpf, nome, nascimento, rg, email, senha, endereco, telefone, cidade, estado, sexo) VALUES( "${req.body.cpf}", "${req.body.nome}", "${req.body.nascimento}", "${req.body.rg}", "${req.body.email}", "${req.body.senha}", "${req.body.endereco}", "${req.body.telefone}", "${req.body.cidade}", "${req.body.estado}", "${req.body.sexo}");`, [], function(err, usuarios){
      if(err){
        res.send(500, {error: "Database error"});
      }
      else
        console.log("cadastro criado com sucesso!");
    });
  },
  about: function(req,res){
    Usuario.query(`SELECT * from banco.usuario WHERE cpf="${req.params.id}";`, ['u'], function(err, usuario) {
      if(err){
        res.send(500, {error: "Database error"});
      }
      res.view('usuario/about', {usuario: usuario[0]});
    })
  },
  edit: function(req,res){
    Usuario.query(`SELECT * from banco.usuario WHERE cpf="${req.params.id}";`, [], function(err, usuario){
      if(err){
        res.send(500, {error: "Database error"});
      }

      res.view('usuario/edit', {usuario: usuario[0]});
    });
  },
  update: function(req,res){
    console.log(`${req.body.nascimento}`);
    Usuario.query(`UPDATE banco.usuario SET nome="${req.body.nome}", nascimento="${req.body.nascimento}", rg="${req.body.rg}", email="${req.body.email}", senha="${req.body.senha}", endereco="${req.body.endereco}", telefone="${req.body.telefone}", cidade="${req.body.cidade}", estado="${req.body.estado}" WHERE cpf="${req.body.cpf}";`, [], function(err, p){
      if(err){
        res.send(500, {error: "Database error"});
      }
      res.redirect('/usuario/list');
    });
  },
  delete:function(req,res){
    Usuario.query(`DELETE FROM banco.usuario WHERE cpf="${req.params.id}";`, [], function(err){
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
