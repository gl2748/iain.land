axis            = require 'axis'
rupture         = require 'rupture'
autoprefixer    = require 'autoprefixer-stylus'
js_pipeline     = require 'js-pipeline'
css_pipeline    = require 'css-pipeline'
dynamic_content = require 'dynamic-content'
jeet            = require 'jeet'


module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '**/.*.swp', '*.swp', '.gitignore', 'ship.*conf']

  extensions: [
    js_pipeline(manifest: 'assets/js/manifest.yml', out: 'js/build.js', minify: true),
    css_pipeline(files: 'assets/css/*.styl'),
    dynamic_content(),
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer(), jeet()]

  jade:
    pretty: true

  server:
    clean_urls: true
