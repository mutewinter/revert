Searcher = require 'lib/searchers/searcher'
DiscussionPage = require 'discussion_page'

module.exports = class HackerNewsSearcher extends Searcher
  name: 'Hacker News'
  templateString: """
  <div>
    <strong>{{title}}</strong>
    <em>{{domain}}</em>
  </div>
  <div>
    <a href="{{commentsURL}}" class="button tiny" target="_blank">{{points}} comments</a>
    <a href="{{pageURL}}" class="button tiny" target="_blank">site</a>
  </div>
  """
  baseURL: 'http://api.thriftdb.com/api.hnsearch.com/items/'

  buildURL: ->
    "#{@baseURL}_search?filter[fields][url][]="+@encode(@url)

  parse: (discussions) ->
    console.log('got discussions', discussions)
    results = _.map discussions.results, (result) ->
      item = result.item

      discussionPage = new DiscussionPage
      discussionPage.title = item.title
      discussionPage.commentsURL =
        "http://news.ycombinator.com/item?id=#{item.id}"
      discussionPage.pageURL = item.url
      discussionPage.domain = item.domain
      discussionPage.points = item.points

      discussionPage

    _.sortBy(results, (discussionPage) -> -discussionPage.points)
