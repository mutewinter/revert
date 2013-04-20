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
          'vendor/scripts/console-helper.js'
          'vendor/scripts/jquery-1.9.0.min.js'
        ]

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^(app|vendor)/
      order:
        before: ['vendor/styles/normalize.css']
        after: []

    templates:
      joinTo: 'javascripts/app.js'
