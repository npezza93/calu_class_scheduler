jQuery ->
    # $("#drawer-menu")[0].setAttribute "selected", "2"

    if $("#offerings-notice").find('paper-toast').length > 0
      document.getElementById('offerings-notice-toast').toggle()

    $("#new-offering-fab").click ->
        document.location.href = '/offerings/new'
        return

    $("#cancel_offering_button").click ->
      window.history.back()
      return

    $("#create-offering").click ->
      $("#new_offering").submit()
      return

    $("#offering_course_id").change ->
      if $("#offering_course_id option:selected" ).val() != ""
        $("#offering_course_id" ).css "color", "#212121"
      else
        $("#offering_course_id" ).css "color", "#757575"
      return

    $("#offering_days_time_id").change ->
      if $("#offering_days_time_id option:selected" ).val() != ""
        $("#offering_days_time_id" ).css "color", "#212121"
      else
        $("#offering_days_time_id" ).css "color", "#757575"
      return

    $("#offering_user_id").change ->
      if $("#offering_user_id option:selected" ).val() != ""
        $("#offering_user_id" ).css "color", "#212121"
      else
        $("#offering_user_id" ).css "color", "#757575"
      return

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
