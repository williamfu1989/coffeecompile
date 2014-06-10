{Subscriber} = require 'emissary'
fs = require 'fs'
coffeescript = require 'coffee-script'
{EditorView} = require 'atom'

module.exports =
class CoffeeCompile
  Subscriber.includeInto(this)
  constructor: ->
    @subscribe atom.workspace.eachEditor (editor) =>
      @handleEvents(editor)
    atom.workspaceView.command 'coffeecompile:compile', (e) =>
      @compileOnSave(atom.workspace.getActiveEditor())
    atom.workspaceView.command 'coffeecompile:preview', (e) =>
      @previewCompile(atom.workspaceView.getActiveView())

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

  previewCompile: (view) ->
    editor = view.getEditor()
    path = editor.getPath()
    pane = atom.workspace.getActivePane()
    newPane = pane.splitRight()
    compiled = coffeescript.compile editor.getText()
    console.log typeof compiled
    #view.splitRight()
    editorView = new EditorView(mini: true)
    # editorView.text compiled
    newPane.activate()
