(function() {
  var React, domWrapper, tag, tags, _i, _len,
    __slice = [].slice;

  ({
    urequire: {
      rootExports: 'hyper'
    }
  });

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
