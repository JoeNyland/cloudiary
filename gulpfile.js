'use strict';

// Require packages
var gulp         = require('gulp');
var sass         = require('gulp-sass');
var concat       = require('gulp-concat');
var gutil        = require('gulp-util');
var uglify       = require('gulp-uglify');
var sourcemaps   = require('gulp-sourcemaps');
var jshint       = require('gulp-jshint');
var sassLint     = require('gulp-sass-lint');
var autoprefixer = require('gulp-autoprefixer');

// Define the default task that's run on `gulp`
gulp.task('default', ['build-css','build-js','watch']);

// Configure which files to watch and what tasks to use on file changes
gulp.task('watch', function() {
  gulp.watch('js/**/*.js', ['build-js']);
  gulp.watch('scss/**/*.scss', ['build-css']);
});

// Concatenate all SCSS files in scss, generate sourcemaps, minify it and output to assets/css/nudge.min.css
gulp.task('build-css', function() {
  return gulp.src('scss/**/*.scss')
    .pipe(sassLint({configFile: '.sass_lint.yml'}))
    .pipe(sassLint.format())
    .pipe(sassLint.failOnError())
    .pipe(sourcemaps.init())
    .pipe(concat('main.min.css'))
    // Only compress for production
    .pipe(gutil.env.type === 'production' ? sass({outputStyle: 'compressed'}).on('error', sass.logError) : sass({outputStyle: 'expanded'}).on('error', sass.logError))
    .pipe(autoprefixer({
      browsers: ['last 3 versions']
     }))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('assets/css'));
});

// Concatenate all Javascript files in js, generate sourcemaps, minify it and output to assets/js/nudge.min.js
gulp.task('build-js', function() {
  return gulp.src('js/**/*.js')
    .pipe(jshint())
    .pipe(jshint.reporter('jshint-stylish'))
    .pipe(sourcemaps.init())
    .pipe(concat('main.min.js'))
    .pipe(gutil.env.type === 'production' ? uglify() : gutil.noop()) // Only uglify if gulp is ran with '--type production'
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('assets/js'));
});
