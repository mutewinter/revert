Searchers = require 'searchers'

console.log Searchers

_.templateSettings = interpolate: /\{\{(.+?)\}\}/g

$ ->
  $('form').on 'submit', (event) ->
    event.preventDefault()
    $('#results').empty()
    url = $('input').val()
    Searchers.search(url)

  # Poor man's tests
  setTimeout(->
    $('input').val('http://github.com/')
    $('form').submit()
  , 100)
