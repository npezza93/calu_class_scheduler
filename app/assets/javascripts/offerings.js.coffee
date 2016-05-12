$(document).on 'page:change', ->
  $('.collapsible').collapsible()
  $('.offering-row').click ->
    document.location.pathname = $(this).attr('href')
    return
