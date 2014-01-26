(function() {
  var fs, path, program, transform;

  path = require('path');

  fs = require('fs');

  program = require('commander');

  transform = require('./transform');

  exports.run = function() {
    var baseName, code, compiled, extension1, extension2, fileName, targetDirectory;
    program.version('0.0.4').usage('outputDirectory pathToFile').description('Compile hyper files to JavaScript').parse(process.argv);
    targetDirectory = program.args[0];
    fileName = program.args[1];
    code = fs.readFileSync(fileName, "utf-8");
    compiled = transform(code);
    extension1 = path.extname(fileName);
    baseName = path.basename(fileName, extension1);
    extension2 = path.extname(baseName);
    if (extension2 === '.h' || extension2 === '.hyper') {
      baseName = path.basename(baseName, extension2);
    }
    return fs.writeFileSync("" + targetDirectory + "/" + baseName + ".js", compiled, "utf-8");
  };

}).call(this);
