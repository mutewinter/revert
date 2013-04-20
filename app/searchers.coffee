searchers = [
  require 'lib/searchers/hacker_news'
  require 'lib/searchers/reddit'
  #require 'lib/searchers/twitter'
]

module.exports =
  search: (url) ->
    _.each searchers, (searcher) ->
      (new searcher).fetchDiscussions(url)
