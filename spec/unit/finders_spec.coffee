require '../spec_helper'

Person = require('models/person').Person

describe 'finders', () ->

  describe '.all', () ->

    it 'is a function', () ->
      expect(typeof(Person.all)).toBe('function')

  describe '.find', () ->

    it 'is a function', () ->
      expect(typeof(Person.find)).toBe('function')
