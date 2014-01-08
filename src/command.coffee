path        = require 'path'
fs          = require 'fs'
transform  = require './transform'

targetDirectory = process.argv[2]
fileName = process.argv[3]

code = fs.readFileSync fileName, "utf-8"
compiled = transform code

baseName = path.basename fileName

while extension = path.extname baseName
  baseName = path.basename baseName

targetFileName = path.basename fileName, fileName
fs.writeFileSync "#{targetDirectory}/#{baseName}.coffee", compiled, "utf-8"
