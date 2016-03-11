module.exports = function (grunt) {
    'use strict';

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-sass');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-concurrent');

    // Project configuration
    grunt.initConfig({
        coffee: {
            dist: {
                options: {
                    bare: true,
                    join: true
                },
                files: {
                    'build/all.js': [
                        'coffee/base_presenter.coffee',
                        'coffee/simple_event_presenter.coffee',
                        'coffee/multiple_subscribers_presenter.coffee',
                        'coffee/two_buses_presenter.coffee',
                        'coffee/event_data_presenter.coffee'
                    ]
                }
            }
        },
        jade: {
            dist: {
                options: {
                    pretty: true
                },
                files: {
                    'build/landing.html': 'jade/landing.jade',
                    'build/simple_event.html': 'jade/simple_event.jade',
                    'build/simple_event_explanation.html': 'jade/simple_event_explanation.jade',
                    'build/multiple_subscribers.html': 'jade/multiple_subscribers.jade',
                    'build/two_buses.html': 'jade/two_buses.jade',
                    'build/two_buses_explanation.html': 'jade/two_buses_explanation.jade',
                    'build/event_data.html': 'jade/event_data.jade'
                }
            }
        },
        sass: {
            dist: {
                options: {
                    sourcemap: 'none'
                },
                files: {
                    'build/all.css': 'sass/all.scss'
                }
            }
        },
        watch: {
            coffee: {
                files: 'coffee/**/*.coffee',
                tasks: ['coffee'],
                options: {
                    interrupt: true,
                    atBegin: true
                }
            },
            jade: {
                files: 'jade/**/*.jade',
                tasks: ['jade'],
                options: {
                    interrupt: true,
                    atBegin: true
                }
            },
            sass: {
                files: 'sass/**/*.scss',
                tasks: ['sass'],
                options: {
                    interrupt: true,
                    atBegin: true
                }
            }
        },
        concurrent: {
            dist: {
                tasks: ['watch:coffee', 'watch:sass', 'watch:jade'],
                options: {
                    logConcurrentOutput: true,
                    limit: 3
                }
            }
        }
    });

    // Default task
    grunt.registerTask('default', [
        'coffee',
        'jade',
        'sass'
    ]);
};