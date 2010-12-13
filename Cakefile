{exec, spawn} = require 'child_process'
util = require 'util'

print = (data) -> util.print data.toString()

task 'build', 'Compile coffeescript files', () ->
  invoke 'spec'
  exec 'rm -rf lib', (error, stdout, stderr) ->
    exec 'mkdir lib && mkdir lib/noid', (error, stdout, stderr) ->
      exec 'coffee -c -o lib src/*.coffee', (error, stdout, stderr) ->
        exec 'coffee -c -o lib/noid src/noid/*.coffee', (error, stdout, stderr) ->

task 'npmlink', 'Link project w/ NPM', () ->
  invoke 'build'
  exec 'npm link', (error, stdout, stderr) ->

task 'spec', 'Run specs', () ->
  bin = spawn './bin/spec'
  bin.stdout.on 'data', print
  bin.stderr.on 'data', print
