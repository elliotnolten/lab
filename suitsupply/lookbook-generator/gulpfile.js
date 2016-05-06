var gulp = require('gulp'),
    browserSync = require('browser-sync').create();
    concat = require('gulp-concat');


gulp.task('browserSync', function() {
  browserSync.init({
    server: {
      baseDir: ''
    },
  });
});

gulp.task('js-concat', function() {
  return gulp.src([
    'app/js/jquery.blendmode.js',
    'node_modules/dropzone/dist/min/dropzone.min.js',
    'node_modules/html2canvas/dist/html2canvas.min.js',
    'node_modules/downloadjs/download.min.js'
  ])
  .pipe(concat('concat.js'))
  .pipe(gulp.dest('app/js'));
});

gulp.task('watch', ['browserSync'], function() {
  gulp.watch('app/*.html', browserSync.reload);
});