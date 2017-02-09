'use strict';

module.exports = function (grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        banner: '/*! <%= pkg.name %> v<%= pkg.version %> | ' +
                'Copyright <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> (<%= pkg.author.email %>) | ' +
                '<%= pkg.license %> */\n',
        coffee: {
            compile: {
                files: {
                    'dist/jquery.phone.js': 'src/jquery.phone.coffee'
                }
            }
        },
        uglify: {
            options: {
                compress: {
                    unsafe: true
                },
                screwIE8: false
            },
            build: {
                files: {
                    'dist/jquery.phone.min.js': 'dist/jquery.phone.js',
                }
            }
        },
        usebanner: {
            dev: {
                options: {
                    position: 'top',
                    banner: '<%= banner %>'
                },
                files: {
                    src: ['dist/*.js']
                }
            }
        },
        watch: {
            options: {
                livereload: true
            },
            files: 'src/**/*.coffee',
            tasks: 'default'
        },
        compare_size: {
            files: [
                'dist/jquery.phone.min.js',
                'dist/jquery.phone.js'
            ],
            options: {
                compress: {
                    gz: function (fileContents) {
                        return require('gzip-js').zip(fileContents, {}).length;
                    }
                }
            }
        }
    });

    // Loading dependencies
    for (var key in grunt.file.readJSON('package.json').devDependencies) {
        if (key !== 'grunt' && key.indexOf('grunt') === 0) {
            grunt.loadNpmTasks(key);
        }
    }

    grunt.registerTask('dev', ['coffee', 'uglify', 'compare_size', 'usebanner']);
    grunt.registerTask('default', 'dev');
};
