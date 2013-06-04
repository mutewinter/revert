MOBILE_SUBDOMAINS = ['mobi', 'mobile', 'm']

# Public: A class that contains an alternate Url and a reason.
class AlternateUrl
  constructor: (@uri, @description) ->
    @url = @uri.toString() if @uri?

au = (uri, description) ->
  new AlternateUrl(uri, description)

module.exports =

  # Public: Generate possible alternate URls given a Url.
  #
  # url - A String Url.
  #
  # Returns an Array of AlternateUrl objects.
  alternate: (url) ->
    urls = []

    uri = URI(url)

    # Don't try if we don't have a domain
    return [] if _.isEmpty(uri.domain())

    # Try old GitHub pages domain
    if uri.domain() is 'github.io' and !_.isEmpty(uri.subdomain())
      urls.push new AlternateUrl(uri.clone().domain('github.com'),
        'Old GitHub pages')

    urls.push au(@removeQuery(uri), 'No query')
    urls.push @alternateSlash(uri)

    # Remove mobile subdomain
    if _.contains(MOBILE_SUBDOMAINS, uri.subdomain())
      noMobile = uri.clone().subdomain('')
      urls.push au(noMobile, 'No mobile subdomain')
      urls.push au(@removeQuery(noMobile), 'No mobile subdomain and query')
      urls.push au(@removeQuery(noMobile.clone().subdomain('www')),
        'www instead of mobile')

    _.chain(urls).compact().uniq().pluck('url').value()

  # Remove query string
  removeQuery: (uri) ->
    uri.clone().query('') unless _.isEmpty(uri.query())

  removeTrailingSlash: (uri) ->
    if /\/$/.test(uri.path())
      au(uri.clone().path(uri.directory()), 'Without trailing slash')

  # Add or remove trailing slash
  alternateSlash: (uri) ->
    if /\/$/.test(uri.path())
      au(uri.clone().path(uri.directory()), 'Without trailing slash')
    else
      au(uri.clone().path(uri.path()+'/'), 'With trailing slash')
