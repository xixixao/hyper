{_div, _h3, _ul, _li, _} = require 'hyper'

_Timer = hyper class Timer
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
      _div "#{@props.label}: #{@state.secondsElapsed}"
      _ul @props.children.map (child) ->
        _li child

hyper.render document.getElementById('example'),
  _Timer label: 'Testing elapsed seconds',
    "First child"
    "Second child"
