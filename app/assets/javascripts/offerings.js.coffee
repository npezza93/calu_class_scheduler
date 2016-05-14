$(document).on 'turbolinks:load', ->
  $('.collapsible').collapsible()
  $('.offering-row').click ->
    document.location.pathname = $(this).attr('href')
    return
