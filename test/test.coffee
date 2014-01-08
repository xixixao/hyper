chai = require 'chai'

transform = require '../lib/hyper/transform'

chai.should()

describe 'hyper', ->
  it 'should automatically import tags', ->
    transform("""
      module.exports = _div()
    """).should.equal """
      {_div} = hyper = require 'hyper'; module.exports = _div()
    """