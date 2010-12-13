require '../spec_helper'

Person = require('models/person').Person

describe 'finders', () ->

  describe 'using string ids', () ->

    person = null

    beforeEach ->
      person = new Person { title: 'Sir', ssn: '696969', pets: true }

    afterEach ->
      runsAndWaits (context) ->
        if person?
          person.delete () ->
            context.done()
        else
          context.done()

    describe '.create', () ->

      it 'saves and returns the document', () ->
        self = this
        runsAndWaits (context) ->
          Person.create { title: 'Sensei', ssn: '666-66-6666' }, (error, p) ->
            person = p
            context.done()
        runs () ->
          expect(person.constructor.name).toEqual('Person')
          expect(person.isNewRecord()).toEqual(false)

    describe '#delete', () ->

      beforeEach ->
        runsAndWaits (context) ->
          person.save (error, person) ->
            context.done()

      it 'deletes the document', () ->
        self = this
        error = null
        runsAndWaits (context) ->
          person.delete (e, person) ->
            Person.find person.id(), (e, person) ->
              error = e
              context.done()
        runs () ->
          expect(error).not.toBeNull()

    describe '#updateAttributes', () ->

      beforeEach ->
        runsAndWaits (context) ->
          person.save (error, person) ->
            context.done()

      describe 'when validation passes', () ->

        it 'to not raise an error', () ->
          error = null
          runsAndWaits (context) ->
            person.updateAttributes { ssn: '555-55-1234' }, (e, person) ->
              error = e
              context.done()
          runs () ->
            expect(error).toBeNull()

        it 'saves the attributes', () ->
          fromDb = null
          runsAndWaits (context) ->
            person.updateAttributes { ssn: '555-55-1235', pets: false, title: null }, (error, p) ->
              Person.find person.id(), (error, p) ->
                fromDb = p
                context.done()
          runs () ->
            expect(fromDb.ssn()).toEqual('555-55-1235')
