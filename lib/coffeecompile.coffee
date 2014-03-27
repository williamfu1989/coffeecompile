CoffeecompileView = require './coffeecompile-view'

coffee = require 'coffee-script'
fs = require 'fs'

module.exports =
  coffeecompileView: null
  configDefaults:
    compileOnSave: true

  activate: (state) ->
    if atom.config.get 'coffeecompile.compileOnSave'
      atom.workspaceView.command 'coffeecompile:compile', (e) =>
        e.abortKeyBinding()
        @compileOnSave()

    # @coffeecompileView = new CoffeecompileView(state.coffeecompileViewState)

  compileOnSave: ->
    editor = atom.workspace.getActiveEditor()
    path = editor.getPath()
    if path.indexOf(".coffee") > -1
      newPath = path.substr(0,path.length-6) + "js"
      compiled = coffee.compile editor.getText()
      fs.writeFile newPath, compiled
