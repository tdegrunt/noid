require '../spec_helper'

vows = require 'vows'
assert = require 'assert'

Person = require('models/person').Person

describe 'finders', () ->
  describe '.all', () ->
    expect(typeof(Person.all)).toBe('function')
