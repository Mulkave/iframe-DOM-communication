fs = require 'fs'
{spawn, exec} = require 'child_process'

launch = (cmd, options=[], callback)->
	app = spawn cmd, options
	app.stdout.pipe(process.stdout)
	app.stderr.pipe(process.stderr)
	app.on 'exit', ->

task 'watch', 'compile and watch', ->

	clientOptions = ['-c', '-w', '-o', './client/js', './client/js/src']
	serverOptions = ['-c', '-w', '-o', './server/js', './server/js/src']
	launch 'coffee', clientOptions
	launch 'coffee', serverOptions

