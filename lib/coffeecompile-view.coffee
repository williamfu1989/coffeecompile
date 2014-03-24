{View} = require 'atom'

module.exports =
class CoffeecompileView extends View
  @content: ->
    @div class: 'coffeecompile overlay from-top', =>
      @div "The Coffeecompile package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "coffeecompile:toggle", => @toggle()

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
