EventEmitter = require('eventemitter2').EventEmitter2
fs = require 'fs'
settings = require '../settings'
spawn = require('child_process').spawn

class Watcher extends EventEmitter
  constructor: (folder, executable) ->
    executable ?= settings.executable
    @process = spawn executable, [folder]
    @process.on 'error', (error) =>
      @emit 'error', error
    @process.stdout.on 'data', (data) =>
      try
        json = JSON.parse data.toString()
        @emit json.event_type, json.src_path
      catch e then @emit 'error', e
    @process.stderr.on 'data', (data) =>
      @emit 'error', data

  close: ->
    @process.kill()

module.exports = Watcher
