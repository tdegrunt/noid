Noid
====

Noid is an ODM (object document mapper) for MongoDB and Node.js written in CoffeeScript.

Example
-------

    class Person extends Document
      
      @storeIn 'people'

      @field 'name'
      @field 'title'

    Person.create { name: 'Chris }

    Person.findFirst { name: 'Chris' }, (error, person) ->
      console.log person.name()

Documentation
-------------

    npm install noid

See the [integration specs](https://github.com/chrisgibson/noid/tree/master/spec/integration) for now...

About
-----

Noid intends to provide a clean way to setup mappings (intended to be created in CoffeeScript, though not required). It is obviously inspired by Mongoid and the api will likely mirror that of Mongoid's, barring any idiomatic deviations.

Credits
-------

Chris Gibson chrislgibson at gmail dot com
