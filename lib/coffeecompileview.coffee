{View} = require 'atom'

module.exports =
class CoffeeCompileView extends View
  @content: (compiled) ->
    @div =>
      @span compiled

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
