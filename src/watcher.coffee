EventEmitter = require('eventemitter2').EventEmitter2
fs = require 'fs'
JSONStream = require 'json-stream'
settings = require '../settings'
spawn = require('child_process').spawn

class Watcher extends EventEmitter
  constructor: (folder, executable) ->
    executable ?= settings.executable
    @process = spawn executable, [folder]
    @process.on 'error', (error) =>
      @emit 'error', error
    jsonStream = JSONStream()
    jsonStream.on 'data', (json) =>
      return unless json.event_type?
      @emit json.event_type, json.src_path
    @process.stdout.pipe jsonStream
    @process.stderr.on 'data', (data) =>
      @emit 'error', data

  close: ->
    @process.kill()

module.exports = Watcher
