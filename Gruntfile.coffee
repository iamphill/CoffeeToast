module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    # Watch task
    watch:
      coffeescript:
        files: ["lib/*.coffee"]
        tasks: ["coffee:compile", "uglify:js"]
      sass:
        files: ["lib/*.scss"]
        tasks: []
    # CoffeeScript task
    coffee:
      compile:
        expand: true,
        flatten: true,
        cwd: "lib",
        src: ["*.coffee"],
        dest: "dist/js",
        ext: ".js"
    # Minify JS
    uglify:
      js:
        files:
          "dist/js/CoffeeToast.min.js": "dist/js/CoffeeToast.js"

  # Load tasks
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-uglify"

  # Register tasks
  grunt.registerTask "default", ["watch"]
