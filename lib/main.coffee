CoffeeCompile = require './coffeecompile'

module.exports =
  configDefaults:
    compileOnSave: true

  activate: ->
    @CoffeeCompile = new CoffeeCompile()

  deactivate: ->
