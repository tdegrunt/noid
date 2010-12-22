require '../spec_helper'
Document = require('noid/document').Document

class Person extends Document

  @field 'ssn'
  @field 'title'

exports.Person = Person
