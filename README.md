# Hyper

React.js wrapper for CoffeeScript.

```coffee
# hello.h.coffee
_HelloMessage = React.createClass
  render: ->
    _div "Hello #{@props.name}"

React.renderComponent (_HelloMessage name: "John"),
  document.getElementById 'container'
```

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
  
  React = require 'React'
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
  
