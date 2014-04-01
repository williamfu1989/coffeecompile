{Subscriber} = require 'emissary'
fs = require 'fs'
coffeescript = require 'coffee-script'

module.exports =
class CoffeeCompile
  Subscriber.includeInto(this)
  constructor: ->
    @subscribe atom.workspace.eachEditor (editor) =>
      @handleEvents(editor)
    atom.workspaceView.command 'coffeecompile:compile', (e) =>
      @compileOnSave()

  handleEvents: (editor) ->
    buffer = editor.getBuffer()
    bufferSavedSubscription = @subscribe buffer, 'will-be-saved', =>
      if atom.config.get "CoffeeCompile.compileOnSave"
        @compileOnSave editor

  compileOnSave: (editor) ->
    path = editor.getPath()
    if path.indexOf(".coffee") > -1
      newPath = path.substr(0,path.length-6) + "js"
      compiled = coffeescript.compile editor.getText()
      fs.writeFile newPath, compiled
