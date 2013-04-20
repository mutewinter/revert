exports.config =
  files:
    javascripts:
      joinTo:
        'javascripts/app.js': (path) ->
          /^app/.test(path) and not /^app\/bookmarklet/.test(path)
        'javascripts/vendor.js': /^vendor/
        'javascripts/bookmarklet.js': /^app\/bookmarklet/
      order:
        before: [
          'vendor/scripts/console-polyfill.js'
          'vendor/scripts/jquery-1.9.1.js'
          'vendor/scripts/underscore.js'
          'vendor/scripts/deep.js'
        ]

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^(app|vendor)/
      order:
        before: ['bootstrap.css']
        after: []

    templates:
      joinTo: 'javascripts/app.js'
