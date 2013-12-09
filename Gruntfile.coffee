module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean: ['bower_components','js', 'dist', 'lib','example/css','example/font', 'example']

    bower:
      install:
        options:
          install: true

    coffee:
      compile:
        files:
          'js/src.js': ['src/**/*.coffee']
        options:
          bare: true
          sourceMap: false

    concat:
      js:
        src: [
          'bower_components/bootstrap3-datetimepicker/build/js/bootstrap-datetimepicker.min.js',
          # 'bower_components/bootstrap/dist/js/bootstrap.js',
          # 'bower_components/jasmine-jquery/lib/jasmine-jquery.js',
          'js/src.js']
        dest: 'dist/angular-bootstrap3-datepicker.js'
      css:
        src: [
          # 'bower_components/bootstrap/dist/css/bootstrap.css',
          'bower_components/bootstrap3-datetimepicker/build/css/bootstrap-datetimepicker.min.css'
        ]
        dest: 'dist/angular-bootstrap3-datepicker.css'

    uglify:
      options:
        mangle: false
      main:
        files:
          'dist/angular-bootstrap3-datepicker.min.js': ['dist/angular-bootstrap3-datepicker.js']

    watch:
      options:
        livereload: true
        spawn: false
        debounceDelay: 50
        atBegin: true
      coffee:
        files: 'src/**/*.coffee'
        tasks: ['coffee:compile', 'concat', 'uglify:main']

    karma:
      'watch-unit':
        configFile: 'build/karma.conf.js'
        autoWatch: true
      'watch-e2e':
        configFile: 'build/karma-e2e.conf.js'
        autoWatch: true
      unit:
        configFile: 'build/karma.conf.js'
        singleRun: true
        browsers: ['PhantomJS']
      e2e:
        configFile: 'build/karma-e2e.conf.js'
        singleRun: true
        browsers: ['PhantomJS']
      everything:
        configFile: 'build/karma-e2e.conf.js'
        singleRun: true
        browsers: ['PhantomJS', 'Firefox', 'Chrome']

    # copy files to exemple directory
    copy:
      js:
        files: [ flatten:true, expand:true, src: [
          'dist/angular-bootstrap3-datepicker.js',
          'lib/bootstrap/*.js',
          'lib/angular/angular.js',
          'lib/jquery/jquery.js',
          'lib/moment/moment.js',
          'bower_components/moment/lang/fr-ca.js'
        ], dest: 'example/js' ]
      css:
        files: [ flatten:true, expand:true, src: [
          'dist/angular-bootstrap3-datepicker.css',
          'lib/font-awesome/css/*.css'
          'lib/bootstrap/*.css'
        ], dest: 'example/css' ]
      font:
        files: [ flatten:true, expand:true, src: [ 'lib/font-awesome/fonts/*' ], dest: 'example/fonts/' ]

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'unit', ['karma:unit']
  grunt.registerTask 'default', [ 'clean', 'bower','coffee', 'concat', 'uglify', 'copy:*','unit' ]

