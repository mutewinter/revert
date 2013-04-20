Searchers = require 'searchers'

_.templateSettings = interpolate: /\{\{(.+?)\}\}/g

$ ->
  $('form').on 'submit', (event) ->
    event.preventDefault()
    $('#results').empty()
    url = $('input').val()
    Searchers.search(url)

  queryParams = URI(window.location.href).query(true)
  if 'url' of queryParams
    Searchers.search(queryParams.url)
