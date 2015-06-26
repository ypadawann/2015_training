
gulp    = require 'gulp'


coffee  = require 'gulp-coffee'

gulp.task 'build:coffee', ->
  gulp.src('src/coffee/*.coffee')
    .pipe(coffee())
    .pipe(gulp.dest('temp/'))
  gulp.src('src/coffee/*/*.coffee')
    .pipe(coffee())
    .pipe(gulp.dest('temp/'))



sass = require 'gulp-sass'

gulp.task 'build:sass', ->
  gulp
    .src 'src/style/*.scss'
    .pipe sass()
    .pipe gulp.dest('dist/style/')

gulpWebpack = require('gulp-webpack')

gulp.task('build:bundle', ['build:coffee'], () ->
  gulp
    .src './temp/*.js'
    .pipe gulpWebpack({
       entry: {
         register: './temp/register.js',
         login: './temp/login.js',
         bookmarklet: './temp/bookmarklet.js',
         userpage: './temp/userpage/userpage.js',
         admin: './temp/admin/admin.js'
       },
       output: {
         filename: '[name].js',
       },
     })
    .pipe gulp.dest('dist/js/')
)

gulp.task 'build:package', ->
  gulp
    .src('node_modules/materialize-css/font/**', { base: 'node_modules/materialize-css' })
    .pipe gulp.dest('dist/style/')

gulp.task 'default', ['build']

gulp.task 'build', [
  'build:bundle'
  'build:sass'
  'build:package'
]


gulp.task 'watch', ->
  gulp.watch 'src/**/*', ['build']
