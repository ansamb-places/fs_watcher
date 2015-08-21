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
      eventsStrings = data.toString().split('}{')
      if eventsStrings.length > 1
        lastIndex = eventsStrings.length - 1
        eventsStrings[0] += '}'
        eventsStrings[lastIndex] = "{#{eventsStrings[lastIndex]}"
        if eventsStrings.length > 2
          for index in [1..eventStrings.length - 2]
            eventsStrings[index] = "{#{eventsStrings[index]}}"
      for eventString in eventsStrings
        try
          eventJson = JSON.parse eventString
          @emit eventJson.event_type, eventJson.src_path
        catch e then @emit 'error', e
    @process.stderr.on 'data', (data) =>
      @emit 'error', data

  close: ->
    @process.kill()

module.exports = Watcher
