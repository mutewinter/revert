Searcher = require 'lib/searchers/searcher'

module.exports = class TwitterSearcher extends Searcher
  name: 'Twitter'
  baseURL: 'http://search.twitter.com/search.json'
  singularName: 'tweet'
  pluralName: 'tweets'
  itemURL: (item) -> debugger

  buildURL: -> @baseURL

  queryData: -> {q: decodeURIComponent(@url), rpp: 50, page: 1}

  itemMap:
    title: 'item.title'
    points: 'item.points'

  rootMap: 'results'
