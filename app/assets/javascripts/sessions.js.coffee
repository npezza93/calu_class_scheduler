# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  componentHandler.upgradeDom()
  # Turbolinks.enableProgressBar(null)

  $("#forgot_password").click (e) ->
    e.preventDefault()
    $(".forgot_password_dialog")[0].showModal()
    return

  $(".close").click (e) ->
    $(this).parent().parent().parent()[0].close();
    return

  if $("#notice").length > 0
    $("#notice")[0].MaterialSnackbar.showSnackbar message: $(".mdl-snackbar__text").text()

    # $("#user_major_id").change ->
    #   if $("#user_major_id option:selected" ).val() != ""
    #     $("#user_major_id" ).css "color", "#212121"
    #   else
    #     $("#user_major_id" ).css "color", "#757575"
    #   return
    #
    # $("#user_advised_by").change ->
    #   if $("#user_advised_by option:selected" ).val() != ""
    #     $("#user_advised_by" ).css "color", "#212121"
    #   else
    #     $("#user_advised_by" ).css "color", "#757575"
    #   return
    #
    # $('#advisor_checkbox').change ->
    #   if $('#advisor_checkbox')[0].checked
    #     $('#actual_advisor').prop "checked", true
    #     $('#user_advised_by').val ''
    #     $('#advisor_collapse')[0].toggle()
    #   else
    #     $('#actual_advisor').prop "checked", false
    #     $('#advisor_collapse')[0].toggle()
    #   return
