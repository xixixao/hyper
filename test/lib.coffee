chai = require 'chai'
chai.should()

React = require 'react'
{run} = require './utils'

describe 'hyper library', ->

  it 'should allow component as first element', ->
    React.isValidComponent run '''
      _div _div()
    '''
    .should.be.true

  it 'should use class name as displayName', ->
    run '''
      hyper class Component
        render: true
    '''
    .componentConstructor.displayName.should.eq 'Component'
