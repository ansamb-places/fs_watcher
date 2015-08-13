fs_watcher
========================

Coffeescript module to interact with python filewatcher.
Requires ansamb_places_watcher_py.

Example
-------

```coffeescript
Watcher = require 'ansamb_places_watcher_js'
watcher = new Watcher('.')
watcher.on 'modified', (filePath) ->
  # ...
```
Install
-----

```
npm install fs_watcher
```

Test
----

```
npm test
```
