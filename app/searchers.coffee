HackerNewsSearcher = require 'lib/searchers/hacker_news'

module.exports =
  search: (url) ->
    (new HackerNewsSearcher).fetchDiscussions(url)
