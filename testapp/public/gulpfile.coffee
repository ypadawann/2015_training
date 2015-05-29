
gulp    = require 'gulp'


coffee  = require 'gulp-coffee'

gulp.task 'build:coffee', ->
  gulp.src('src/coffee/*.coffee')
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
         read_data: ['./temp/attendance_record.js', './temp/read_data.js'],
         register: './temp/register.js',
         userpage: './temp/userpage.js',
         login: './temp/login.js',
         userdata_modify: './temp/userdata_modify.js'
         admin_user: './temp/admin_user.js'
         admin_top: './temp/admin_top.js'
         admin_login: './temp/admin_login.js'
         admin_department: './temp/admin_department.js'
         admin_modify: './temp/admin_modify.js'
         admin_register: './temp/admin_register.js'
       },
       output: {
         filename: '[name].js',
       },
     })
    .pipe gulp.dest('dist/js/')
)


gulp.task 'default', ['build']

gulp.task 'build', [
  'build:bundle'
  'build:sass'
]


gulp.task 'watch', ->
  gulp.watch 'src/**/*', ['build']
