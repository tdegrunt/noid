require '../spec_helper'

Person = require('models/person').Person

describe 'finders', () ->

  describe 'using string ids', () ->

    documents = null
    document = null

    beforeEach ->
      self = this
      runsAndWaits (context) ->
        documents = []
        Person.create { title: 'Mrs.', ssn: 'another' }, (error, person) ->
          self.document = person
          context.done()

    afterEach ->
      runsAndWaits (context) ->
        Person.deleteAll () ->
          context.done()

    describe 'with an id as an argument', () ->

      describe 'when the document is found', () ->

        it 'returns the document', () ->
          self = this
          person = null
          runsAndWaits (context) ->
            Person.find self.document.id(), (error, p) ->
              person = p
              context.done()
          runs () ->
            expect(person).not.toBeNull()
            expect(person.id()).toEqual(@document.id())

      describe 'when the document is not found', () ->

        it 'raises an error', () ->
          error = null
          runsAndWaits (context) ->
            Person.find '5', (e, person) ->
              error = e
              context.done()
          runs () ->
            expect(error).not.toBeNull()

