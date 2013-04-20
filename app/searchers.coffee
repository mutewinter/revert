searchers = [
  require 'lib/searchers/hacker_news'
  require 'lib/searchers/reddit'
  #require 'lib/searchers/twitter'
]

module.exports =
  search: (url) ->
    $('#results').append($("""
      <div>Searching for <a href="#{url}" target="_blank">#{url}</a></div>
    """))
    _.each searchers, (searcher) ->
      (new searcher).fetchDiscussions(url)
