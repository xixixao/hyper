tags = require './tags'

domWrapper = (tag) ->
  (attributes, contents...) ->
    if typeof attributes is 'object' and not React.isValidComponent attributes
      React.DOM[tag] attributes, contents
    else
      React.DOM[tag] {}, attributes, contents

for tag in tags
  module.exports["_#{tag}"] = domWrapper tag
