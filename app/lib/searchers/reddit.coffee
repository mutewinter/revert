Searcher = require 'lib/searchers/searcher'

module.exports = class RedditSearcher extends Searcher
  name: 'Reddit'
  baseURL: 'http://www.reddit.com/api/info.json?jsonp=?'
  singularName: 'comment'
  pluralName: 'comments'

  itemURL: (item) -> "http://www.reddit.com#{item.data.permalink}"
  buildURL: -> @baseURL
  makeDate: (rawDate) ->
    console.log rawDate
    date = new Date(0)
    date.setUTCSeconds(rawDate)
    date

  queryData: (url) -> {url: decodeURIComponent(url)}

  itemMap:
    title: 'data.title'
    points: 'data.score'
    comments: 'data.num_comments'
    date: 'data.created_utc'

  rootMap: 'data.children'
