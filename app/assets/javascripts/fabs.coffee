$(document).on 'turbolinks:load', ->
  if $(".transcript-upload-dialog").length > 0
    dialogPolyfill.registerDialog($(".transcript-upload-dialog")[0])
    $(".transcript-upload-fab").click (e) ->
      e.preventDefault()
      $(".transcript-upload-dialog")[0].showModal()
      return

  $(".new_major_fab").click ->
    $(".new_major_dialog")[0].showModal()

  $("#upload-fab").click ->
    $("#upload_offering_button")[0].click()
    $("#upload_offering_button").on "change", ->
      $("#upload-offerings-form").submit()
      return
    return

  $(".upload_offering_fab").click ->
    $("#upload_offering_file")[0].click()
    $("#upload_offering_file").on 'change', ->
      $("#upload_offering_file").parent().submit()
      return
    return
