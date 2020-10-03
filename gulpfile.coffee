gulp = require("gulp")
concat = require("gulp-concat")
coffee = require('gulp-coffee')
browser_sync = require("browser-sync")
embed_templates = require("gulp-angular-embed-templates")
prefixer = require("gulp-autoprefixer")

config = {
  server: {
    baseDir: "./dist"
  },
  tunnel: false,
  port: 80,
  single: true
}


gulp.task 'build:js', ->
  gulp.src(['src/**/mainApp.coffee', 'src/**/*.coffee'])
    .pipe(coffee({bare: true}))
    .pipe(embed_templates())
    .pipe(concat('main.js'))
    .pipe(gulp.dest('dist/js'))


gulp.task 'build:js_library', ->
  gulp.src(['./node_modules/angular/angular.js', './node_modules/angular-ui-router/release/angular-ui-router.js'])
    .pipe(concat('library.js'))
    .pipe(gulp.dest('dist/js'))

gulp.task 'build:css', ->
  gulp.src('src/**/*.css')
    .pipe(prefixer())
    .pipe(concat('template.css'))
    .pipe(gulp.dest('dist/css'))

gulp.task 'build:html', ->
  gulp.src('src/index.html')
    .pipe(concat('index.html'))
    .pipe(gulp.dest('dist'))

gulp.task('build', gulp.series('build:js', 'build:js_library', 'build:html', 'build:css'))

gulp.task "project:watch", ->
  browser_sync(config)
  gulp.watch('src/**/*.coffee', gulp.series("build:js"))
  gulp.watch('src/coffee/**/*.html', gulp.series("build:js"))
  gulp.watch('src/index.html', gulp.series("build:html"))
  gulp.watch('src/**/*.css', gulp.series("build:css"))









