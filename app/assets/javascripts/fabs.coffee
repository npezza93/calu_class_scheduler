$(document).on 'turbolinks:load', ->
  if $(".transcript-upload-dialog").length > 0
    dialogPolyfill.registerDialog($(".transcript-upload-dialog")[0])
    $(".transcript-upload-fab").click (e) ->
      e.preventDefault()
      $(".transcript-upload-dialog")[0].showModal()
      return
