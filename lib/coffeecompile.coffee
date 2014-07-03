{Subscriber} = require 'emissary'
fs = require 'fs'
coffeescript = require 'coffee-script'
{EditorView} = require 'atom'
CoffeeCompileView = require './coffeecompileview'
{$, $$$,View} = require 'atom'

module.exports =
class CoffeeCompile
  Subscriber.includeInto(this)
  constructor: ->
    @subscribe atom.workspace.eachEditor (editor) =>
      @handleEvents(editor)
    atom.workspaceView.command 'coffeecompile:compile', (e) =>
      @compileOnSave()
    atom.workspaceView.command 'coffeecompile:preview', (e) =>
      @previewCompile()

  handleEvents: (editor) ->
    buffer = editor.getBuffer()
    bufferSavedSubscription = @subscribe buffer, 'will-be-saved', =>
      if atom.config.get "CoffeeCompile.compileOnSave"
        @compileOnSave editor

  compileOnSave: () ->
    editor = atom.workspace.getActiveEditor()
    path = editor.getPath()
    if path.indexOf(".coffee") > -1
      newPath = path.substr(0,path.length-6) + "js"
      compiled = coffeescript.compile editor.getText()
      fs.writeFile newPath, compiled

  previewCompile: () ->
    view = atom.workspaceView.getActiveView()
    editor = view.getEditor()
    # path = editor.getPath()
    title = editor.getTitle()
    pane = atom.workspace.getActivePane()
    newPane = pane.splitRight()
    text = coffeescript.compile editor.getText()
    try
      text = @compile code
    catch e
      text = e.stack

    grammar = atom.syntax.selectGrammar("hello.js", text)

    for tokens in grammar.tokenizeLines(text)
      attributes = class: "line"
      console.log EditorView.buildLineHtml({tokens, text, attributes})
    console.log @compiledCode
    # #view.splitRight()
    # editorView = new EditorView(mini: true)
    # editorView.text compiled
    # newPane.activate()
    view = new CoffeeCompileView(compiled)
    view.setTitle title.substring(0, title.length-6)+'js'
    newPane.addItem view, 0

    # atom.workspaceView.appendToRight(new View)
