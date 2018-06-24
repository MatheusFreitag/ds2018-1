/**
 * Automovel.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {
  //migrate: 'safe',
  attributes: {
    placa:{
      type: 'string',
      unique: 'true'
    },
    modelo:{
      type: 'string'
    },
    cor:{
      type: 'string'
    },
    chassi:{
      type: 'string'
    },
    disponibilidade:{
      type: 'boolean'
    },
    dataInicio:{
      type: 'date'
    },
    dataFim:{
      type: 'date'
    },
    descricao:{
      type: 'string'
    },
    fotoVeiculo:{
      type: 'string'
    },
    fotoDocumento:{
      type: 'string'
    },
    possuiSeguro:{
      type: 'boolean'
    },
    status: {
      type: 'boolean'
    },
    cidade: {
      type: 'string'
    },
    estado:{
      type: 'string'
    },
    avaliacao:{
      type: 'int'
    },
    cpf: {
      type: 'string'
    },
    numeroDeAvalicoes:{
      type: 'int'
    }
  },
  primaryKey: 'placa',
  connection: 'mysql',
  autoPK:false
};

