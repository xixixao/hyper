# Hyper

React.js wrapper for CoffeeScript.

```coffee
hyper class HelloMessage
  render: ->
    _div
      "Hello #{@props.name}"

hyper.render document.getElementById('container'),
  _HelloMessage name: _strong "John"
```

Library Features:

- `hyper class` declaration adds `displayName` for debugging
- components don't require props as first argument
- `_` prefixed bultin tags allow nice syntax
- `render` method swaps order of arguments of `renderComponent`

Transform Features:

- `hyper class` declaration adds `_` prefixed variable to the current scope
- tags get auto required
- component implicit calling allows nicer syntax
- interpolation in component children allows components between strings

see [facebook/react](https://github.com/facebook/react)


# Using Transform

```
npm install -g hyper
hyper ./ my_component.h.coffee
```

Creates `my_component.js`

## Using Library

Via bower:
```
bower install hyper
```

- Using RequireJS (with CommonJS syntax):

  ```coffee
  require
    paths:
      react: 'bower_components/react/react'
      hyper: 'bower_components/hyper/hyper'

  # ...

  {_div, _h3, _ul, _li, _} = require 'hyper'
  ```

- Using globals:

  ```html
  <script src='bower_components/react/react'></script>
  <script src='bower_components/hyper/hyper'></script>
  ```
  ```coffee
  {_div, _h3, _ul, _li, _} = hyper
  ```
