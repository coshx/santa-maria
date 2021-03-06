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
                        'coffee/landing_presenter.coffee',
                        'coffee/slideshow/simple_event_presenter.coffee',
                        'coffee/slideshow/multiple_subscribers_presenter.coffee',
                        'coffee/slideshow/two_events_presenter.coffee',
                        'coffee/slideshow/two_buses_presenter.coffee',
                        'coffee/slideshow/event_data_presenter.coffee',
                        'coffee/time_benchmark_data.coffee',
                        'coffee/time_benchmark_presenter.coffee',
                        'coffee/responsiveness_benchmark_presenter.coffee',
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
                    'build/slideshow_landing.html': 'jade/slideshow/slideshow_landing.jade',
                    'build/simple_event.html': 'jade/slideshow/simple_event.jade',
                    'build/simple_event_explanation.html': 'jade/slideshow/simple_event_explanation.jade',
                    'build/multiple_subscribers.html': 'jade/slideshow/multiple_subscribers.jade',
                    'build/two_events.html': 'jade/slideshow/two_events.jade',
                    'build/two_buses.html': 'jade/slideshow/two_buses.jade',
                    'build/two_buses_explanation.html': 'jade/slideshow/two_buses_explanation.jade',
                    'build/event_data.html': 'jade/slideshow/event_data.jade',
                    'build/time_benchmark.html': 'jade/time_benchmark.jade',
                    'build/responsiveness_benchmark.html': 'jade/responsiveness_benchmark.jade'
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