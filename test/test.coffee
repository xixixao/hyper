chai = require 'chai'

React = require 'React'

transform = require '../lib/hyper/transform'
log = (i) -> console.log i; i
run = (hyperCoffee) -> eval log transform hyperCoffee

chai.should()

describe 'hyper', ->
  it 'should automatically import tags', ->
    React.isValidComponent(run '''
      _div()
    ''').should.be.true

  it 'should allow component as first element', ->
    React.isValidComponent(run '''
      _div _div()
    ''').should.be.true

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

  fakeComponents = '''
    _strong = -> 'world'
    _div = (args...) -> args.join ', '
    _article = (props, children...) -> [props].concat children...

  '''

  it 'should allow components inside interpolation', ->
    (run fakeComponents + '''
      _div "Hello #{_strong 'traveller'}."
    ''').should.equal 'Hello , world, .'

  it 'should allow nested interpolations', ->
    (run fakeComponents + '''
      _div "Hello #{_div "my #{_strong 'plan'} is?"}."
    ''').should.equal 'Hello , my , world,  is?, .'

  it 'should allow mixing interpolations and argument interpolations', ->
    (run fakeComponents + '''
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

