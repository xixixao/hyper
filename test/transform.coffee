chai = require 'chai'
chai.should()

React = require 'react'

{run} = require './utils'

describe 'hyper transform', ->
  it 'should enable yaml-like syntax', ->
    React.isValidComponent(run '''
      _div
        _div()
    ''').should.be.true

    React.isValidComponent(run '''
      _div style: width: 30,
        _div()
    ''').should.be.true

    React.isValidComponent(run '''
      _div
        style:
          width: 30
        _div()
    ''').should.be.true

  it 'should hoist hyper classes as underscored components', ->
    React.isValidComponent(run '''
      hyper class Component
        render: ->
      _Component()
    ''').should.be.true

  describe 'interpolations', ->
    runFake = (hyperCoffee) -> run '''
      _strong = -> 'world'
      _div = (args...) -> args.join ', '
      _article = (props, children...) -> [props].concat children...

    ''' + hyperCoffee

    it 'should allow components inside interpolation', ->
      (runFake '''
        _div "Hello #{_strong 'traveller'}."
      ''').should.equal 'Hello , world, .'

    it 'should allow nested interpolations', ->
      (runFake '''
        _div "Hello #{_div "my #{_strong 'plan'} is?"}."
      ''').should.equal 'Hello , my , world,  is?, .'

    it 'should allow mixing interpolations and argument interpolations', ->
      (runFake '''
        _article
          style:
            compilicated: "something #{'here'}"
          "#{_strong
            _em
              "Something #{'very'} complex"
          } is happening"
          _div "Hello straight #{'away'}"
      ''').should.eql [
        style: compilicated: 'something here'
        ''
        'world'
        ' is happening'
        'Hello straight , away'
      ]
