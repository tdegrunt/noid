require '../spec_helper'

Person = require('models/person').Person

describe 'document', () ->

  beforeEach ->
    runsAndWaits (context) ->
      Person.deleteAll () ->
        context.done()

  describe '.find', () ->

    beforeEach ->
      runsAndWaits (context) ->
        Person.create { title: 'Test' }, () ->
          context.done()

    describe 'finding all documents', () ->

      it 'returns an array of documents based on the selector provided', () ->
        people = null
        runsAndWaits (context) ->
          Person.findAll { conditions: { title: 'Test' } }, (error, p) ->
            people = p
            context.done()
        runs () ->
          expect(people[0].title()).toEqual('Test')

    describe 'finding first document', () ->

      it 'returns the first document basked on the selector provided', () ->
        person = null
        runsAndWaits (context) ->
          Person.findFirst { conditions: { title: 'Test' } }, (error, p) ->
            person = p
            context.done()
        runs () ->
          expect(person.title()).toEqual('Test')
