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

    if uri.domain() is 'github.io' and !_.isEmpty(uri.subdomain())
      urls.push new AlternateUrl(uri.domain('github.com'),
        'Old GitHub pages')
    unless _.isEmpty(uri.query())
      urls.push new AlternateUrl(uri.query(''), 'No query')

    _.pluck(urls, 'url')
