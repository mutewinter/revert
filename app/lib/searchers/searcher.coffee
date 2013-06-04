DiscussionPage = require 'lib/models/discussion_page'

module.exports = class Searcher
  templateString: """
  <div class="row-fluid">
    <a href="{{commentsURL}}">
      {{title}}
    </a>
  </div>
  <strong>{{points}}<i class="icon-arrow-up"></i> |</strong>
  <a href="{{commentsURL}}">
    <strong> {{comments}} {{itemType}}</strong>
  </a>
  | <time title="{{date}}" datetime="{{date}}">{{relativeDate}}</time>
  """

  search: (url) ->
    @fetchDiscussions(url)
    @runAlternateSearches(url)

  fetchDiscussions: (url) ->
    $.ajax(
      url: @buildURL(url)
      data: @queryData(url) if @queryData
      dataType: 'jsonp'
      success: $.proxy(@render, this)
      error: $.proxy(@error, this)
    )

  runAlternateSearches: (url) ->
    uri = URI(url)
    if uri.domain() is 'github.io'
      @fetchDiscussions(uri.domain('github.com').toString())
    unless _.isEmpty(uri.query())
      @fetchDiscussions(uri.query('').toString())

  encode: (url) ->
    encodeURIComponent(decodeURIComponent(url))

  error: ->
    console.error('Error fetching', url)

  render: (data) ->
    discussionPages = @parse(data)

    $ul = $('<ul class="unstyled discussions">')
    _.each discussionPages, (discussionPage) =>
      $li = $('<li>')
      $li.append _.template(@templateString, discussionPage)
      $ul.append $li

    $('#results').append($("<h2>#{@name}</h2>"))
    $('#results').append($ul)

  parse: (data) ->
    results = _.map _.deep(data, @rootMap), (result) =>
      discussionPage = new DiscussionPage
      discussionPage.title = _.deep result, @itemMap.title
      discussionPage.points = _.deep result, @itemMap.points
      discussionPage.comments = _.deep result, @itemMap.comments
      discussionPage.commentsURL = @itemURL(result)
      discussionPage.date = @makeDate(_.deep(result, @itemMap.date))
      discussionPage.relativeDate = @relativeDate discussionPage.date
      discussionPage.itemType =
        if discussionPage.points is 1 then @singularName else @pluralName

      discussionPage

    _.sortBy(results, (discussionPage) -> -discussionPage.points)

  relativeDate: (date) -> relativeDate(date)
