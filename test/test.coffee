expect = require('chai').expect
fs = require 'fs'
path = require 'path'
Watcher = require '../lib/watcher'

describe 'watcher', ->
  testFolder = 'test'
  testFile = path.join testFolder, 'test.txt'

  before (done) ->
    fs.writeFile testFile, 'Initial write', done

  it 'should spawn a watcher process', (done) ->
    watcher = new Watcher(testFolder)
    watcher.on 'modified', (filePath) ->
      expect(filePath).to.equal testFile
      done()
    setTimeout ->
      fs.appendFile testFile, 'write', (err) ->
        done(err) if err?
    , 1000

  after (done) ->
    fs.unlink testFile, done
