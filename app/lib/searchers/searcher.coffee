module.exports = class Searcher
  fetchDiscussions: (url) ->
    console.log('Fetching discussoins for', url)

    @url = url
    $.ajax(
      url: @buildURL()
      data: @queryData() if @queryData
      dataType: "jsonp"
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
    $('#results').append($ul)

  # -------------------------------------------
  # Requred methods for subclasses to implement
  # -------------------------------------------

  _notImplemented: -> console.error('not implemented')
  fetch: -> @_notImplemented
  # Internal: Returns an array of Page objects.
  parse: -> @_notImplemented
  buildURL: -> @_notImplemented
