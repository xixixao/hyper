transform = require '../src/transform'

module.exports =
  # hyper is available via symlinked node_modules/hyper
  run: (hyperCoffee) -> eval transform hyperCoffee