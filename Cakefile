fs            = require 'fs'
path          = require 'path'
{spawn, exec} = require 'child_process'

CoffeeScript = (args...) -> spawn 'node_modules/coffee-script/bin/coffee', args

URequire = (args...) -> spawn 'node_modules/urequire/build/code/urequireCmd.js', args

Mocha = 'node_modules/mocha/bin/mocha --compilers coffee:coffee-script'

build = (cb) ->
  files = fs.readdirSync 'src'
  files = ("src/#{file}" for file in files)
  CoffeeScript '-c', '-o', 'lib/hyper', files...
  cb?()

task 'build', 'build for nodejs', build

task 'build:browser', 'rebuild the merged script for inclusion in the browser', ->
  build ->
  	exec 'mkdir extras'
  	URequire 'combined', 'lib/hyper', '-o', 'extras/hyper.js'

task 'test', 'run mocha test', ->
  build ->
    exec Mocha, (error, stdout, stderr) ->
      console.log stdout
      console.error stderr
