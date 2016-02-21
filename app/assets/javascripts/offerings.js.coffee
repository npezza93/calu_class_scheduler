jQuery ->
    $("#upload-fab").click ->
      $("#upload_offering_button")[0].click()
      $("#upload_offering_button").on "change", ->
        $("#upload-offerings-form").submit()
        return
      return

    $("#show-upload-offering-details").click ->
      text = $('#show-upload-offering-details').text().trim()
      if text == "Show Upload Details"
        text = "Hide Upload Details"
      else
        text = "Show Upload Details"
      $('#show-upload-offering-details').text(text)
      $("#upload-offering-details")[0].toggle()
      return
