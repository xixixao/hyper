# Converts hyper coffee into vanilla coffee
# source = """
#   _table
#     _tbody
#       _tr
#         _th 'Header'
#         _td 'Value'
#       _th
#         _td 'John'
#         _td '$25'
# """

tags = require './tags'
CoffeeScript = require 'coffee-script'

# Puts the import line on the first line, so the source code is not offset
# and error locations are correct
module.exports = (source) ->
  importingTags = tagsToImport source
  normalizedSource = normalizeComponentCalls underscoreHyperClasses source
  imported = "{#{importingTags.join ', '}} = hyper = require 'hyper'; #{normalizedSource}"
  (interpolate imported).compile(bare: true)

# Adds an empty object literal, so the code becomes valid CS
normalizeComponentCalls = (source) ->
  normalize = (source) ->
    source.replace ///
      (
        (?:^|\s|\#\{) # either new line, literal space or interpolation
        (\s*) # possible indentation
        _\w+ # tag
      )
      (
        \s*\n # last thing on the line
        \2 # equal indentation on next line
        [^\S\n]+ # more indentation
      )
      (
        [^\n]+ # the following line
      )
    ///g, (match, tag, _, indent, following) ->
      if (identifier = following.match ///^ #{IDENTIFIER}///) and identifier[2]
        # property access, there is a props object already
        match
      else
        "#{tag} {},#{indent}#{following}"

  # two passes, because we match before and after the replace
  normalize normalize source

underscoreHyperClasses = (source) ->
  source.replace ///(hyper\sclass\s#{IDENTIFIER})///, '_$2 = $1'

potentialTags = (source) ->
  (source.match /_\w+/g) or []

tagsToImport = (source) ->
  map = {}
  for tag in potentialTags source
    if tag[1..] in tags
      map[tag] = true
  tag for tag, set of map when set

# nodewalk from macros.coffee
nodewalk = (n, visit, dad = undefined) ->
  return unless n.children
  dad = n if n.expressions
  for name in n.children
    return unless kid = n[name]
    if kid instanceof Array
      for child, i in kid
        visit child, ((node) -> kid[i] = node), dad
        nodewalk child, visit, dad
    else
      visit kid, ((node)-> kid = n[name] = node), dad
      nodewalk kid, visit, dad
  n

interpolate = (source) ->
  nodes = CoffeeScript.nodes source
  # console.log nodes.toString()

  nodewalk nodes, (node, set) ->
    if isTagNode node
      node.args[0..] = [].concat (
        interpolatingNode arg for arg in node.args
      )...
      # console.log "ARGS"
      # node.args.map (args) -> console.log  arg.toString()
      # console.log "ARGS"

isTagNode = (node) ->
  node.constructor.name is 'Call' and node.variable.base.value?[0] is '_'

interpolatingNode = (node) ->
  if node.constructor.name is 'Op' and node.operator is '+' and
      [node.first, node.second].some isStringNode
    [].concat [ interpolatingNode node.first
      interpolatingNode node.second ]...
  else if child = isWrappedNode node
    interpolatingNode child
  else
    [node]

isWrappedNode = (node) ->
  if node.constructor.name in ['Parens', 'Block'] and node.children.length is 1 or
      node.constructor.name is 'Value' and node.properties.length is 0
    children = []
    node.eachChild (child) -> children.push child
    children[0]
  else
    false

isStringNode = (node) ->
  if IS_STRING.test node.base?.value
    node
  else if child = isWrappedNode node
    isStringNode child
  else
    false

IS_STRING = /^['"]/

IDENTIFIER = ///
  ( [$A-Za-z_\x7f-\uffff][$\w\x7f-\uffff]* )
  ( [^\n\S]* : (?!:) )?  # Is this a property name?
///.source