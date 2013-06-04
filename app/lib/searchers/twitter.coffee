Searcher = require 'lib/searchers/searcher'

module.exports = class TwitterSearcher extends Searcher
  name: 'Twitter'
  baseUrl: 'http://search.twitter.com/search.json'
  singularName: 'tweet'
  pluralName: 'tweets'
  itemUrl: (item) -> debugger

  buildUrl: -> @baseUrl

  queryData: -> {q: decodeURIComponent(@url), rpp: 50, page: 1}

  itemMap:
    title: 'item.title'
    points: 'item.points'

  rootMap: 'results'
