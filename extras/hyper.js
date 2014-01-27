(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
(function() {
  var React, domWrapper, tag, tags, _i, _len,
    __slice = [].slice;

  tags = require('./tags');

  React = require('react');

  module.exports = function(classDeclaration) {
    classDeclaration.prototype.displayName = classDeclaration.name;
    return React.createClass(classDeclaration.prototype);
  };

  module.exports.render = function(node, component) {
    return React.renderComponent(component, node);
  };

  domWrapper = function(tag) {
    return function() {
      var attributes, contents, _ref, _ref1;
      attributes = arguments[0], contents = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      if (typeof attributes === 'object' && !(Array.isArray(attributes)) && !(React.isValidComponent(attributes))) {
        return (_ref = React.DOM)[tag].apply(_ref, [attributes].concat(__slice.call(contents)));
      } else {
        return (_ref1 = React.DOM)[tag].apply(_ref1, [{}].concat(__slice.call([attributes].concat(contents))));
      }
    };
  };

  for (_i = 0, _len = tags.length; _i < _len; _i++) {
    tag = tags[_i];
    module.exports["_" + tag] = domWrapper(tag);
  }

}).call(this);

},{"./tags":2,"react":"9MMk62"}],2:[function(require,module,exports){
(function() {
  module.exports = ['a', 'abbr', 'address', 'applet', 'area', 'article', 'aside', 'audio', 'b', 'base', 'bdi', 'bdo', 'big', 'blockquote', 'body', 'br', 'button', 'canvas', 'caption', 'circle', 'cite', 'code', 'col', 'colgroup', 'command', 'data', 'datalist', 'dd', 'del', 'details', 'dfn', 'dialog', 'div', 'dl', 'dt', 'ellipse', 'em', 'embed', 'fieldset', 'figcaption', 'figure', 'footer', 'form', 'g', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'head', 'header', 'hgroup', 'hr', 'html', 'i', 'iframe', 'img', 'input', 'ins', 'kbd', 'keygen', 'label', 'legend', 'li', 'line', 'link', 'main', 'map', 'mark', 'marquee', 'menu', 'menuitem', 'meta', 'meter', 'nav', 'noscript', 'object', 'ol', 'optgroup', 'option', 'output', 'p', 'param', 'path', 'polyline', 'pre', 'progress', 'q', 'rect', 'rp', 'rt', 'ruby', 's', 'samp', 'script', 'section', 'select', 'small', 'source', 'span', 'strong', 'style', 'sub', 'summary', 'sup', 'svg', 'table', 'tbody', 'td', 'text', 'textarea', 'tfoot', 'th', 'thead', 'time', 'title', 'tr', 'track', 'u', 'ul', 'var', 'video', 'wbr'];

}).call(this);

},{}]},{},[1])