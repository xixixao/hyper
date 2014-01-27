(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
(function() {
  var CoffeeScript, IDENTIFIER, IS_STRING, interpolate, interpolatingNode, isStringNode, isTagNode, isWrappedNode, nodewalk, normalizeComponentCalls, potentialTags, tags, tagsToImport, underscoreHyperClasses,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  tags = require('./tags');

  CoffeeScript = require('coffee-script');

  module.exports = function(source) {
    var imported, importingTags, normalizedSource;
    importingTags = tagsToImport(source);
    normalizedSource = normalizeComponentCalls(underscoreHyperClasses(source));
    imported = "{" + (importingTags.join(', ')) + "} = hyper = require 'hyper'; " + normalizedSource;
    return (interpolate(imported)).compile({
      bare: true
    });
  };

  normalizeComponentCalls = function(source) {
    var normalize;
    normalize = function(source) {
      return source.replace(/((?:^|\s|\#\{)(\s*)_\w+)(\s*\n\2[^\S\n]+)([^\n]+)/g, function(match, tag, _, indent, following) {
        var identifier;
        if ((identifier = following.match(RegExp("^" + IDENTIFIER))) && identifier[2]) {
          return match;
        } else {
          return "" + tag + " {}," + indent + following;
        }
      });
    };
    return normalize(normalize(source));
  };

  underscoreHyperClasses = function(source) {
    return source.replace(RegExp("(hyper\\sclass\\s" + IDENTIFIER + ")"), '_$2 = $1');
  };

  potentialTags = function(source) {
    return source.match(/_\w+/g);
  };

  tagsToImport = function(source) {
    var map, set, tag, _i, _len, _ref, _ref1, _results;
    map = {};
    _ref = potentialTags(source);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      tag = _ref[_i];
      if (_ref1 = tag.slice(1), __indexOf.call(tags, _ref1) >= 0) {
        map[tag] = true;
      }
    }
    _results = [];
    for (tag in map) {
      set = map[tag];
      if (set) {
        _results.push(tag);
      }
    }
    return _results;
  };

  nodewalk = function(n, visit, dad) {
    var child, i, kid, name, _i, _j, _len, _len1, _ref;
    if (dad == null) {
      dad = void 0;
    }
    if (!n.children) {
      return;
    }
    if (n.expressions) {
      dad = n;
    }
    _ref = n.children;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      name = _ref[_i];
      if (!(kid = n[name])) {
        return;
      }
      if (kid instanceof Array) {
        for (i = _j = 0, _len1 = kid.length; _j < _len1; i = ++_j) {
          child = kid[i];
          visit(child, (function(node) {
            return kid[i] = node;
          }), dad);
          nodewalk(child, visit, dad);
        }
      } else {
        visit(kid, (function(node) {
          return kid = n[name] = node;
        }), dad);
        nodewalk(kid, visit, dad);
      }
    }
    return n;
  };

  interpolate = function(source) {
    var nodes;
    nodes = CoffeeScript.nodes(source);
    return nodewalk(nodes, function(node, set) {
      var arg, _ref, _ref1;
      if (isTagNode(node)) {
        return ([].splice.apply(node.args, [0, 9e9].concat(_ref = (_ref1 = []).concat.apply(_ref1, (function() {
          var _i, _len, _ref1, _results;
          _ref1 = node.args;
          _results = [];
          for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
            arg = _ref1[_i];
            _results.push(interpolatingNode(arg));
          }
          return _results;
        })()))), _ref);
      }
    });
  };

  isTagNode = function(node) {
    var _ref;
    return node.constructor.name === 'Call' && ((_ref = node.variable.base.value) != null ? _ref[0] : void 0) === '_';
  };

  interpolatingNode = function(node) {
    var child, _ref;
    if (node.constructor.name === 'Op' && node.operator === '+' && [node.first, node.second].some(isStringNode)) {
      return (_ref = []).concat.apply(_ref, [interpolatingNode(node.first), interpolatingNode(node.second)]);
    } else if (child = isWrappedNode(node)) {
      return interpolatingNode(child);
    } else {
      return [node];
    }
  };

  isWrappedNode = function(node) {
    var children, _ref;
    if (((_ref = node.constructor.name) === 'Parens' || _ref === 'Block') && node.children.length === 1 || node.constructor.name === 'Value' && node.properties.length === 0) {
      children = [];
      node.eachChild(function(child) {
        return children.push(child);
      });
      return children[0];
    } else {
      return false;
    }
  };

  isStringNode = function(node) {
    var child, _ref;
    if (IS_STRING.test((_ref = node.base) != null ? _ref.value : void 0)) {
      return node;
    } else if (child = isWrappedNode(node)) {
      return isStringNode(child);
    } else {
      return false;
    }
  };

  IS_STRING = /^['"]/;

  IDENTIFIER = /([$A-Za-z_\x7f-\uffff][$\w\x7f-\uffff]*)([^\n\S]*:(?!:))?/.source;

}).call(this);

},{"./tags":2,"coffee-script":"dE97MS"}],2:[function(require,module,exports){
(function() {
  module.exports = ['a', 'abbr', 'address', 'applet', 'area', 'article', 'aside', 'audio', 'b', 'base', 'bdi', 'bdo', 'big', 'blockquote', 'body', 'br', 'button', 'canvas', 'caption', 'circle', 'cite', 'code', 'col', 'colgroup', 'command', 'data', 'datalist', 'dd', 'del', 'details', 'dfn', 'dialog', 'div', 'dl', 'dt', 'ellipse', 'em', 'embed', 'fieldset', 'figcaption', 'figure', 'footer', 'form', 'g', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'head', 'header', 'hgroup', 'hr', 'html', 'i', 'iframe', 'img', 'input', 'ins', 'kbd', 'keygen', 'label', 'legend', 'li', 'line', 'link', 'main', 'map', 'mark', 'marquee', 'menu', 'menuitem', 'meta', 'meter', 'nav', 'noscript', 'object', 'ol', 'optgroup', 'option', 'output', 'p', 'param', 'path', 'polyline', 'pre', 'progress', 'q', 'rect', 'rp', 'rt', 'ruby', 's', 'samp', 'script', 'section', 'select', 'small', 'source', 'span', 'strong', 'style', 'sub', 'summary', 'sup', 'svg', 'table', 'tbody', 'td', 'text', 'textarea', 'tfoot', 'th', 'thead', 'time', 'title', 'tr', 'track', 'u', 'ul', 'var', 'video', 'wbr'];

}).call(this);

},{}]},{},[1])