hyper
=====

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
