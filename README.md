Noid
====

Noid is an ODM (object document mapper) for MongoDB and Node.js written in CoffeeScript.

Example:

    class Person extends Document

      @field 'name'
      @field 'title'

    Person.create { name: 'Chris }

    Person.findFirst { name: 'Chris' }, (error, person) ->
      console.log person.name()
