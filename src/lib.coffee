tags = require './tags'
React = require 'react'

# For debugging, pull out displayName from class declaration
#
# hyper class Component
#   render: -> _div()
#
module.exports = (classDeclaration) ->
  classDeclaration::displayName = classDeclaration.name
  React.createClass classDeclaration::

# Swap node and component, better coffee syntax
#
# hyper.render document.getElementById('test'),
#   _Test prop: 'test'
#     _child()
#
module.exports.render = (node, component) ->
  React.renderComponent component, node

# Allow child components as first argument to parent component
#
# _Test _div()
#
domWrapper = (tag) ->
  (attributes, contents...) ->
    if typeof attributes is 'object' and
        not (Array.isArray attributes) and
        not (React.isValidComponent attributes)
      React.DOM[tag] attributes, contents...
    else
      React.DOM[tag] {}, ([attributes].concat contents)...

# Prefix bultin tags with underscore for better readability
for tag in tags
  module.exports["_#{tag}"] = domWrapper tag
