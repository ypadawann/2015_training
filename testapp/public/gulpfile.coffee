
gulp    = require 'gulp'


coffee  = require 'gulp-coffee'

gulp.task 'build:coffee', ->
  gulp.src('src/coffee/*.coffee')
    .pipe(coffee())
    .pipe(gulp.dest('dist/script/'))



sass = require('gulp-sass')

gulp.task 'build:sass', ->
  gulp
    .src('src/style/*.scss')
    .pipe(sass())
    .pipe(gulp.dest('dist/style/'))


# source = require 'vinyl-source-stream'
# webpack = require('gulp-webpack')
#
# gulp.task 'build:bundle', ['build:coffee', 'build:jade', 'build:sass'], shell.task [
#   'webpack'
# ]


gulp.task 'default', ['build']

gulp.task 'build', [
  'build:coffee'
  'build:sass'
]


gulp.task 'watch', ->
  gulp.watch 'src/**/*', ['build']
