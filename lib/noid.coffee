require.paths.unshift __dirname

mongo = require 'mongodb'

class Noid

Noid.collections = () ->
  return this.db().collections

Noid.configure = (options) ->
  this.host = options.host || 'localhost'
  this.port = options.port || 27017
  this.name = options.name

Noid.db = (callback) ->
  callback(null, @_db) if @_db?
  db = new mongo.Db @name, new mongo.Server(@host, @port)
  db.open (error, client) ->
    @_db = db
    callback(error, db)

exports.Noid = Noid
