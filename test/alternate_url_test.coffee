AlternateUrls = require 'lib/services/alternate_urls'

describe 'AlternateUrls', ->

  it 'should strip query parameters', ->
    urls = AlternateUrls.alternate('http://www.kickstarter.com/projects/doublefine/double-fines-massive-chalice?ref=home_popular')
    expect(urls).to.include('http://www.kickstarter.com/projects/doublefine/double-fines-massive-chalice')

  it 'should convert github domains', ->
    urls = AlternateUrls.alternate('http://xyz.github.io/test')
    expect(urls).to.include('http://xyz.github.com/test')

  it 'should not github domains without a subdomain', ->
    urls = AlternateUrls.alternate('http://github.io/test')
    expect(urls).not.to.include('http://github.com/test')
