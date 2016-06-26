c = -> console.log.apply console, arguments
spawn = require('child_process').spawn
chokidar = require 'chokidar'
# path = require 'path'


chokidar.watch('.').on 'change', (event, path) ->
    c 'file changed recompiling...', event
    if event.split('.')[1] is 'tex'
        args = ['-output-directory=build', event]
        opts =
            cwd: './'

        new_minimal = spawn('xelatex',args, opts)
        new_minimal.stdout.on 'data', (data) -> c data.toString()
        new_minimal.stderr.on 'data', (data) -> c data.toString()
        new_minimal.on 'close', (code) -> c code
