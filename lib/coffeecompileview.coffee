{View} = require 'atom'
{EditorView} = require 'atom'

module.exports =
class CoffeeCompileView extends View
  @content: () ->
    @div class: 'coffeecompile native-key-bindings', tabindex: -1, =>
      @div class: 'editor editor-colors', =>
        @div outlet: "compiled", class: 'lang-javascript lines'

  initialize: (serializeState) ->

  getTitle: ->
    @title

  setTitle: (title) ->
    @title = title

  setContent: (compiled) ->
    @compiled = compiled

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "CoffeecompileView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)

  render: (text) ->
    grammar = atom.syntax.selectGrammar("hello.js", text)

    for tokens in grammar.tokenizeLines(text)
      attributes = class: "line"
      @compiled.append EditorView.buildLineHtml({tokens, text, attributes})

    @compiled.css
      fontSize: atom.config.get('editor.fontSize') or 12
      fontFamily: atom.config.get('editor.fontFamily')
