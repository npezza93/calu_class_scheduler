$(document).on 'turbolinks:load', ->
  $('.offering-row').click ->
    document.location.pathname = $(this).attr('href')
    return
