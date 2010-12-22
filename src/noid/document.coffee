util = require('util')
_ = require('underscore')._
en = require('lingo').en

ObjectID = require('mongodb/bson/bson').ObjectID

Noid = require('noid').Noid

class Document

  constructor: (@attributes) ->
    @attributes ?= {}

  delete: (callback) ->
    self = this
    attributes = @attributes
    @.constructor._ensureCollectionIsSetup (error, collection) ->
      if error?
        callback error, null
        return
      collection.remove { _id: attributes._id }, (error) ->
        if error?
          callback error, null
          return
        callback null, self

  id: () ->
    if @isNewRecord() then null else @attributes._id.toHexString()

  isNewRecord: () ->
    if @attributes._id? then false else true

  save: (callback) ->
    self = this
    attributes = @attributes
    if @isNewRecord()
      @.constructor._ensureCollectionIsSetup (error, collection) ->
        if error?
          callback 'Error inserting document: ' + error, self
          return
        collection.insert attributes, (error) ->
          if error?
            callback 'Error inserting document: ' + error, self
            return
          callback(error, self)
    else
      @.constructor._ensureCollectionIsSetup (error, collection) ->
        collection.update { _id: attributes._id }, attributes, (error) ->
          callback(error, self)

  updateAttributes: (attributes, callback) ->
    for key, value of attributes
      @attributes[key] = value
    @save(callback)

  @field: (name) ->
    @::[name] = (val) ->
      if arguments.length > 0
        @attributes[name] = val
      else
        @attributes[name]

  @storeIn: (collection_name) ->
    @::_storeIn = collection_name

  @_ensureCollectionIsSetup = (callback) ->
    self = this
    # Pluralize and downcase class name for the collection name if storeIn not already set
    @::.storeIn ||= en.pluralize(self.name.toString()).toLowerCase()
    collectionName = @::._storeIn ? self.name.toString()
    Noid.db (error, db) ->
      if error?
        callback 'Error establishing database connection: ' + error, null
        return
      db.createCollection collectionName, (error) ->
        if error?
          callback 'Error creating collection: ' + error, null
          return
        db.collection collectionName, (error, collection) ->
          if error?
            callback 'Error using collection: ' + error, null
            return
          callback(error, collection)

  @all = (callback) ->
    self = this
    this._ensureCollectionIsSetup (error, collection) ->
      if error?
        callback error, null
        return
      collection.find (error, cursor) ->
        if error?
          callback error, null
          return
        cursor.toArray (error, documents) ->
          instances = _.map documents, (document) -> new self(document)
          callback null, instances

  @create = (attributes, callback) ->
    document = new this(attributes)
    document.save (error, doc) ->
      callback error, doc

  @deleteAll = (callback) ->
    this._ensureCollectionIsSetup (error, collection) ->
      if error?
        callback error
        return
      collection.remove { }, (error) ->
        if error?
          callback error
          return
        callback null

  @find = (id, callback) ->
    self = this
    this._ensureCollectionIsSetup (error, collection) ->
      if error?
        callback error, null
        return
      collection.findOne { "_id": ObjectID.createFromHexString(id) }, (error, document) ->
        if error?
          callback error, null
          return
        if document?
          callback(null, new self(document))
        else
          callback('Document not found', null)

  @findAll = (options, callback) ->
    self = this
    this._ensureCollectionIsSetup (error, collection) ->
      if error?
        callback error, null
        return
      collection.find options.conditions, (error, cursor) ->
        if error?
          callback error, null
          return
        cursor.toArray (error, documents) ->
          instances = _.map documents, (document) -> new self(document)
          callback null, instances

  @findFirst = (options, callback) ->
    self = this
    this._ensureCollectionIsSetup (error, collection) ->
      if error?
        callback error, null
        return
      collection.findOne options.conditions, (error, document) ->
        if error?
          callback error, null
          return
        if document?
          callback(null, new self(document))
        else
          callback('Document not found', null)

exports.Document = Document

