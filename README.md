# hyper

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

With bower and RequireJS
```
bower install hyper
```

```coffee
require
  paths:
    React: 'bower_components/react/react'
    hyper: 'bower_components/hyper/hyper'
    
# ...

React = require 'React'
{_div, _h3, _ul, _li, _} = require 'hyper'


