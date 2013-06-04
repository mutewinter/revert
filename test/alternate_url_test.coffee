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

  it 'should add a missing trailing slash', ->
    urls = AlternateUrls.alternate('http://test.com/1')
    expect(urls).to.include('http://test.com/1/')

  it 'should remove a trailing slash', ->
    urls = AlternateUrls.alternate('http://test.com/1/')
    expect(urls).to.include('http://test.com/1')

  it 'should convert mobile urls to desktop urls', ->
    urls = AlternateUrls.alternate('http://mobile.slate.com/blogs/the_slatest/2013/06/03/turkey_faq_what_s_happening_in_istanbul_will_recep_tayyip_erdogan_be_ousted.html')
    expect(urls).to.include('http://slate.com/blogs/the_slatest/2013/06/03/turkey_faq_what_s_happening_in_istanbul_will_recep_tayyip_erdogan_be_ousted.html')
