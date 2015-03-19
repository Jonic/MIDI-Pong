
'use strict';

var autoprefixer = require('gulp-autoprefixer');
var gulp         = require('gulp');
var coffee       = require('gulp-coffee');
var concat       = require('gulp-concat');
var notify       = require("gulp-notify");
var sass         = require('gulp-sass');
var sourcemaps   = require('gulp-sourcemaps');
var util         = require('gulp-util');

function handleError (error) {
  error = error.toString();
  util.log(error);
  notify(error);
  this.emit('end');
}

var config = {
  paths: {
    scripts: {
      files: {
        any:         'assets/scripts/**/*.coffee',
        utils:       'assets/scripts/utils.coffee',
        helpers:     'assets/scripts/helpers/**/*.coffee',
        classes:     'assets/scripts/classes/**/*.coffee',
        bootstrap:   'assets/scripts/bootstrap.coffee'
      },
      dest: 'public/scripts'
    },
    styles: {
      files: {
        any:   'assets/styles/**/*.scss',
        input: 'assets/styles/master.scss'
      },
      dest: 'public/styles'
    }
  },
  targets: {
    ios: 'Pop\ Rush/WebApp',
  }
};

gulp.task('scripts', function () {
  var files = config.paths.scripts.files;

  return gulp.src([
      files.utils,
      files.helpers,
      files.classes,
      files.bootstrap
    ])
    .on('error', handleError)
    .pipe(sourcemaps.init())
    .on('error', handleError)
    .pipe(coffee({
      bare: true
    }))
    .on('error', handleError)
    .pipe(concat('application.js'))
    .on('error', handleError)
    .pipe(sourcemaps.write())
    .on('error', handleError)
    .pipe(gulp.dest(config.paths.scripts.dest))
    .on('error', handleError);
});

gulp.task('styles', function () {
  var files = config.paths.styles.files;

  return gulp.src(files.input)
    .pipe(sourcemaps.init())
    .on('error', handleError)
    .pipe(sass({
      compressed: false
    }))
    .on('error', handleError)
    .pipe(autoprefixer())
    .on('error', handleError)
    .pipe(sourcemaps.write())
    .on('error', handleError)
    .pipe(gulp.dest(config.paths.styles.dest))
    .on('error', handleError);
});

gulp.task('watch', function () {
  gulp.watch(config.paths.scripts.files.any, ['scripts']);
  gulp.watch(config.paths.styles.files.any,  ['styles']);
});

gulp.task('default', [
  'scripts',
  'styles',
  'watch'
]);
