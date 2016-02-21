$(document).on 'turbolinks:load', ->
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
