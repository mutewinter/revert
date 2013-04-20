Searchers = require 'searchers'

_.templateSettings = interpolate: /\{\{(.+?)\}\}/g

$ ->
  queryParams = URI(window.location.href).query(true)
  url = queryParams.url
  if url?
    $('input').val(url)
    Searchers.search(url)

  $('form').on 'submit', (event) ->
    event.preventDefault()
    $('#results').empty()
    url = $('input').val()
    Searchers.search(url)
