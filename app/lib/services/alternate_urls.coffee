# Public: A class that contains an alternate Url and a reason.
class AlternateUrl
  constructor: (@uri, @description) ->
    @url = @uri.toString()

module.exports =
  # Public: Generate possible alternate URls given a Url.
  #
  # url - A String Url.
  #
  # Returns an Array of AlternateUrl objects.
  alternate: (url) ->
    urls = []

    uri = URI(url)

    # Try old GitHub pages domain
    if uri.domain() is 'github.io' and !_.isEmpty(uri.subdomain())
      urls.push new AlternateUrl(uri.clone().domain('github.com'),
        'Old GitHub pages')

    # Remove query string
    unless _.isEmpty(uri.query())
      urls.push new AlternateUrl(uri.clone().query(''), 'No query')

    # Add or remove trailing slash
    if /\/$/.test(uri.path())
      urls.push new AlternateUrl(uri.clone().path(uri.directory()),
        'Without trailing slash')
    else
      urls.push new AlternateUrl(uri.clone().path(uri.path()+'/'),
        'With trailing slash')

    _.pluck(urls, 'url')
