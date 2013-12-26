urequire:
  rootExports: 'hyper'

tags = require './tags'
React = require 'React'

flatten = (array) ->
  if Array.isArray array
    [].concat array...
  else
    array

domWrapper = (tag) ->
  (attributes, contents...) ->
    if typeof attributes is 'object' and
        not (Array.isArray attributes) and
        not (React.isValidComponent attributes)
      React.DOM[tag] attributes, flatten contents
    else
      React.DOM[tag] {}, flatten [attributes].concat contents

for tag in tags
  module.exports["_#{tag}"] = domWrapper tag
