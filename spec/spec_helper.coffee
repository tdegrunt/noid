require.paths.unshift __dirname + '/../node_modules'
require.paths.unshift __dirname + '/../src'
require.paths.unshift __dirname + '/../spec'

global.util = require('util')
global.inspect = util.inspect

global._ = require('underscore')._

Noid = require('noid').Noid

Noid.configure {
  db: 'noid_test',
  host: 'localhost'
}

Noid.db (error) ->

# From http://groups.google.com/group/jasmine-js/browse_thread/thread/bb7413123579e390/c68340f61bd29cc4
global.runsAndWaits = (fn, timeoutMessage, timeout) ->
  _done = false
  context = { done: () -> _done = true }
  runs () -> fn context
  waitsFor (() -> return _done), timeoutMessage, timeout
