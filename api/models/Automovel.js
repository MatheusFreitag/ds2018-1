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
      type: 'number'
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
      type: 'number'
    },
    status: {
      type: 'number'
    },
    cidade: {
      type: 'string'
    },
    estado:{
      type: 'string'
    },
    avaliacao:{
      type: 'number'
    },
    cpf: {
      type: 'string'
    },
    numeroDeAvalicoes:{
      type: 'number'
    }
  },
  primaryKey: 'placa',
  connection: 'mysql',
  autoPK:false
};

