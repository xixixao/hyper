chai = require 'chai'
chai.should()

React = require 'react'
{run} = require './utils'

describe 'hyper library', ->
  it 'should automatically import tags', ->
    React.isValidComponent(run '''
      _div()
    ''').should.be.true

  it 'should allow component as first element', ->
    React.isValidComponent(run '''
      _div _div()
    ''').should.be.true
