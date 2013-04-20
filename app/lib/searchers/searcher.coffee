DiscussionPage = require 'discussion_page'

module.exports = class Searcher
  templateString: """
  <strong>{{points}}<i class="icon-arrow-up"></i> |</strong>
  <a href="{{commentsURL}}" target="_blank">
    <strong> {{comments}} {{itemType}}</strong> | {{title}}
  </a>
  """

  fetchDiscussions: (url) ->
    @url = url
    $.ajax(
      url: @buildURL()
      data: @queryData() if @queryData
      dataType: 'jsonp'
      success: $.proxy(@render, this)
      error: $.proxy(@error, this)
    )

  encode: (url) ->
    encodeURIComponent(decodeURIComponent(url))

  error: ->
    console.error('Error fetching', url)

  render: (data) ->
    discussionPages = @parse(data)

    $ul = $('<ul class="unstyled">')
    _.each discussionPages, (discussionPage) =>
      $li = $('<li>')
      $li.append _.template(@templateString, discussionPage)
      $ul.append $li

    $('#results').append($("<h2>#{@name}</h2>"))
    $('#results').append($("""
      <div>Searched for <a href="#{@url}" target="_blank">#{@url}</a></div>
    """))
    $('#results').append($ul)

  parse: (data) ->
    results = _.map _.deep(data, @rootMap), (result) =>
      discussionPage = new DiscussionPage
      discussionPage.title = _.deep result, @itemMap.title
      discussionPage.points = _.deep result, @itemMap.points
      discussionPage.comments = _.deep result, @itemMap.comments
      discussionPage.commentsURL = @itemURL(result)
      discussionPage.itemType =
        if discussionPage.points is 1 then @singularName else @pluralName

      discussionPage

    _.sortBy(results, (discussionPage) -> -discussionPage.points)

  # -------------------------------------------
  # Requred methods for subclasses to implement
  # -------------------------------------------

  _notImplemented: -> console.error('not implemented')
  fetch: -> @_notImplemented
  # Internal: Returns an array of Page objects.
  buildURL: -> @_notImplemented
