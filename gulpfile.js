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

// Concatenate all SCSS files in scss, generate sourcemaps, minify it and output to assets/css/cloudiary.min.css
gulp.task('build-css', ['sass-lint'], function() {
  return gulp.src('scss/**/[^_]*.?(s)css')
    .pipe(sourcemaps.init())
    .pipe(concat('cloudiary.min.css'))
    // Only compress for production
    .pipe(gutil.env.type === 'production' ? sass({outputStyle: 'compressed'}).on('error', sass.logError) : sass({outputStyle: 'expanded'}).on('error', sass.logError))
    .pipe(autoprefixer({
      browsers: ['last 3 versions']
     }))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('assets/css'));
});

// Concatenate all Javascript files in js, generate sourcemaps, minify it and output to assets/js/cloudiary.min.js
gulp.task('build-js', ['jshint'], function() {
  return gulp.src('js/**/*.js')
    .pipe(sourcemaps.init())
    .pipe(concat('cloudiary.min.js'))
    .pipe(gutil.env.type === 'production' ? uglify() : gutil.noop()) // Only uglify if gulp is ran with '--type production'
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('assets/js'));
});

gulp.task('sass-lint', function() {
  return gulp.src(['scss/**/*.?(s)css','!scss/plugins/*'])
    .pipe(sassLint({configFile: '.sass_lint.yml'}))
    .pipe(sassLint.format())
    .pipe(sassLint.failOnError());
});

gulp.task('jshint', function() {
  return gulp.src(['js/**/*.js', '!js/plugins/*'])
    .pipe(jshint())
    .pipe(jshint.reporter('jshint-stylish'));
});
