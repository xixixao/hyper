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

# Puts the import line on the first line, so the source code is not offset
# and error locations are correct
module.exports = (source) ->
  tags = tagsToImport source
  normalizedSource = normalizeComponentCalls source
  "{#{tags.join ', '}} = hyper = require 'hyper'; #{normalizedSource}"

normalizeComponentCalls = (source) ->
  normalize = (source) ->
    source.replace ///
      (
        (?:^|\n) # first thing on the line
        (\s*) # indentation (new line doesn't matter)
        _\w+ # tag
      )
      (
        \s*\n # last thing on the line
        \2 # equal indentation on next line
        [^\S\n]+ # more indentation
      )
    ///g, '$1 {},$3'
  # two passes, because we match before and after the replace
  normalize normalize source

potentialTags = (source) ->
  source.match /_\w+/g

tagsToImport = (source) ->
  (potentialTags source).filter (tag) -> tag[1..] in tags

# This is taken from original CS compiler, it has known problems, but
# works in most cases
balancedString = (str, end) ->
  continueCount = 0
  stack = [end]
  for i in [1...str.length]
    if continueCount
      --continueCount
      continue
    switch letter = str.charAt i
      when '\\'
        ++continueCount
        continue
      when end
        stack.pop()
        unless stack.length
          return str[0..i]
        end = stack[stack.length - 1]
        continue
    if end is '}' and letter in ['"', "'"]
      stack.push end = letter
    else if end is '}' and letter is '/' and match = (HEREGEX.exec(str[i..]) or REGEX.exec(str[i..]))
      continueCount += match[0].length - 1
    else if end is '}' and letter is '{'
      stack.push end = '}'
    else if end is '"' and prev is '#' and letter is '{'
      stack.push end = '}'
    prev = letter
  # shouldn't get here, error


# Regex-matching-regexes.
REGEX = /// ^
  (/ (?! [\s=] )   # disallow leading whitespace or equals signs
  [^ [ / \n \\ ]*  # every other thing
  (?:
    (?: \\[\s\S]   # anything escaped
      | \[         # character class
           [^ \] \n \\ ]*
           (?: \\[\s\S] [^ \] \n \\ ]* )*
         ]
    ) [^ [ / \n \\ ]*
  )*
  /) ([imgy]{0,4}) (?!\w)
///

HEREGEX      = /// ^ /{3} ((?:\\?[\s\S])+?) /{3} ([imgy]{0,4}) (?!\w) ///


