/**
 * Usuario.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {
  //migrate: 'alter',
  attributes: {
    cpf:{
      type: 'string',
      unique: 'true'
    },
    nome:{
      type: 'string'
    },
    nascimento:{
      type: 'number'
    },
    rg:{
      type: 'boolean'
    },
    email:{
      type: 'string'
    },
    senha:{
      type: 'boolean'
    },
    foto:{
      type: 'string'
    },
    endereco:{
      type: 'string'
    },
    telefone: {
      type: 'string'
    },
    cidade:{
      type: 'string'
    },
    estado:{
      type: 'string'
    },
    avaliacao:{
      type: 'int'
    },
    numeroDeAvalicoes:{
      type: 'int'
    }
  },
  primaryKey: 'cpf',
  connection: 'mysql',
  autoPK:false
};

