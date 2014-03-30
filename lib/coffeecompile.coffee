CoffeecompileView = require './coffeecompile-view'

coffee = require 'coffee-script'
fs = require 'fs'

module.exports =
  coffeecompileView: null
  configDefaults:
    compileOnSave: true

  activate: (state) ->
    atom.workspaceView.command 'coffeecompile:compile', (e) =>
      e.abortKeyBinding()
      if atom.config.get 'CoffeeCompile.compileOnSave'
        @compileOnSave()

  compileOnSave: ->
    editor = atom.workspace.getActiveEditor()
    path = editor.getPath()
    if path.indexOf(".coffee") > -1
      newPath = path.substr(0,path.length-6) + "js"
      compiled = coffee.compile editor.getText()
      fs.writeFile newPath, compiled
