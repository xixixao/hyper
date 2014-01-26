Hyper uses gulp for building. Use `npm test` to run the test suite.

    gulp = require 'gulp'
    gutil = require 'gulp-util'
    clean = require 'gulp-clean'
    coffee = require 'gulp-coffee'
    browserify = require 'gulp-browserify'
    rename = require 'gulp-rename'

By default build all, then watch all sources and create all targets.

    gulp.task 'default', ['build', 'watch']
    gulp.task 'build', ->
      gulp.run 'clean'
      gulp.run 'lib', 'extras'

We need to build everything if lib changes.

    gulp.task 'watch', ->
      gulp.watch 'src/**/*', ['lib', 'extras']

Remove all built files.

    gulp.task 'clean', ->
    gulp.src ['lib/hyper/', 'extras'], read: no
        .pipe clean()

Compile lib from CoffeeScript

    gulp.task 'lib', ->
      gulp.src 'src/**/*.coffee'
        .pipe coffee()
          .on 'error', gutil.log
        .pipe gulp.dest 'lib/hyper'

Using browserify because the result is smaller than with almond.

    gulp.task 'extras', ['lib'], ->
      gulp.src 'lib/hyper/lib.js'
        .pipe browserify debug: !gulp.env.production, external: ['react']
        .pipe rename 'hyper.js'
        .pipe gulp.dest 'extras'
      # gulp.src 'lib/hyper/transform.js'
      #   .pipe browserify {debug: !gulp.env.production}
      #   # .pipe rename 'compiler.js'
      #   .pipe gulp.dest 'extras'
