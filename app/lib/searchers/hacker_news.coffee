Searcher = require 'lib/searchers/searcher'

module.exports = class HackerNewsSearcher extends Searcher
  name: 'Hacker News'
  baseUrl: 'http://api.thriftdb.com/api.hnsearch.com/items/'
  singularName: 'comment'
  pluralName: 'comments'

  itemUrl: (item) -> "http://news.ycombinator.com/item?id=#{item.item.id}"
  makeDate: (rawDate) -> new Date(rawDate)
  buildUrl: (url) ->
    "#{@baseUrl}_search?filter[fields][url][]="+@encode(url)

  itemMap:
    title: 'item.title'
    points: 'item.points'
    comments: 'item.num_comments'
    date: 'item.create_ts'

  rootMap: 'results'
