(function() {
  var lib, transform;

  lib = require('./lib');

  transform = require('./transform');

  lib.compile = transform;

  module.exports = lib;

}).call(this);
