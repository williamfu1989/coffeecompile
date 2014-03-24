CoffeecompileView = require './coffeecompile-view'

module.exports =
  coffeecompileView: null

  activate: (state) ->
    @coffeecompileView = new CoffeecompileView(state.coffeecompileViewState)

  deactivate: ->
    @coffeecompileView.destroy()

  serialize: ->
    coffeecompileViewState: @coffeecompileView.serialize()
