Searcher = require 'lib/searchers/searcher'
DiscussionPage = require 'discussion_page'

module.exports = class HackerNewsSearcher extends Searcher
  name: 'Hacker News'
  templateString: """
  <a href="{{commentsURL}}" class="btn btn-link" target="_blank">
    <strong>{{points}} comments</strong> | {{title}}
  </a>
  """
  baseURL: 'http://api.thriftdb.com/api.hnsearch.com/items/'

  buildURL: ->
    "#{@baseURL}_search?filter[fields][url][]="+@encode(@url)

  itemMap:
    title: 'item.title'

  rootMap: 'results'

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
