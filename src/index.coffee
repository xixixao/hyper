urequire:
  rootExports: 'hyper'

tags = require './tags'
React = require 'React'

domWrapper = (tag) ->
  (attributes, contents...) ->
    if typeof attributes is 'object' and
        not (Array.isArray attributes) and
        not (React.isValidComponent attributes)
      React.DOM[tag] attributes, contents...
    else
      React.DOM[tag] {}, ([attributes].concat contents)...

for tag in tags
  module.exports["_#{tag}"] = domWrapper tag
