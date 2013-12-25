# domWrapper = (tag) ->
#   (attributes, contents...) ->
#     if typeof attributes is 'object' and not React.isValidComponent attributes
#       React.DOM[tag] attributes, contents
#     else
#       React.DOM[tag] {}, attributes, contents

# {_div} = _div: domWrapper 'div'

{_div, _h3, _ul, _li, _} = require 'hyper'
# React = require 'React'

Timer = React.createClass
  getInitialState: ->
    secondsElapsed: 0

  tick: ->
    @setState
      secondsElapsed: @state.secondsElapsed + 1

  componentDidMount: ->
    @interval = setInterval @tick, 1000

  componentWillUnmount: ->
    clearInterval @interval

  render: ->
    _div {},
      _h3 "Example"
      _ul @props.children.map (child) ->
        _li child
      _div "#{@props.label}: #{@state.secondsElapsed}"

_Timer = Timer

module.exports = ->
  timer =
    _Timer label: 'Testing elapsed seconds',
      "Adam"
      "Barbara"
  React.renderComponent timer, document.getElementById('example')
