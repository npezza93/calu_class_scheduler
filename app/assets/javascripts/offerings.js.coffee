$(document).on 'turbolinks:load', ->
  $('.collapsible').collapsible()
  $('.table-row').click ->
    document.location.pathname = $(this).attr('href')
    return

  $("#upload-offerings").click (e) ->
    e.preventDefault()
    $("#upload-offerings-dialog")[0].showModal()
    return

  $('.choose-file').click (e) ->
    e.preventDefault()
    $("#offering_file").click()
    return

  $("#offering_file").on 'change', ->
    $(this).parent().submit()
    return
