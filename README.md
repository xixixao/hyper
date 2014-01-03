# Hyper

React.js wrapper for CoffeeScript.

```coffee
_HelloMessage = hyper class HelloMessage
  render: ->
    _div "Hello #{@props.name}"

hyper.render document.getElementById('container'),
  _HelloMessage name: "John"
```

Features:

- `hyper class` declaration adds `displayName` for debugging
- components don't require props as first argument
- `_` prefixed bultin tags allow nice syntax
- `render` method swaps order of arguments of `renderComponent`

see [facebook/react](https://github.com/facebook/react)

## Install

Via bower:
```
bower install hyper
```

- Using RequireJS (with CommonJS syntax):

  ```coffee
  require
    paths:
      React: 'bower_components/react/react'
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
