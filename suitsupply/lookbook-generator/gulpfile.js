var gulp = require('gulp');
var browserSync = require('browser-sync').create();

gulp.task('browserSync', function() {
  browserSync.init({
    server: {
      baseDir: ''
    },
  });
});

gulp.task('watch', ['browserSync'], function() {
  gulp.watch('app/*.html', browserSync.reload);
});