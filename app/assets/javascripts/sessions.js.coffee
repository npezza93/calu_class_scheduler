# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $(document).load ->
      if $("#session-notice").find('paper-toast').length > 0
        $("#session-notice").find('paper-toast')[0].toggle()
      $("#new_session_overlay")[0].fit()
      return

    $("#forgot_password").click ->
        document.getElementById('forgot-dialog').toggle()
        
    $("#one").click (e) ->
      if $("#paperTabs")[0].selected != "0"
        $("#baluga")[0].selected = 0
        $("#baluga").attr 'entry-animation', 'slide-from-right-animation'
        $("#baluga").attr 'exit-animation', 'slide-left-animation'
      return

    $("#two").click (e) ->
      $("#baluga")[0].selected = 1
      $("#baluga").attr 'entry-animation', 'slide-from-left-animation'
      $("#baluga").attr 'exit-animation', 'slide-right-animation'
      return

    $("#user_major_id").change ->
      if $("#user_major_id option:selected" ).val() != ""
        $("#user_major_id" ).css "color", "#212121"
      else
        $("#user_major_id" ).css "color", "#757575"
      return

    $("#user_advised_by").change ->
      if $("#user_advised_by option:selected" ).val() != ""
        $("#user_advised_by" ).css "color", "#212121"
      else
        $("#user_advised_by" ).css "color", "#757575"
      return

    $('#advisor_checkbox').change ->
      if $('#advisor_checkbox')[0].checked
        $('#actual_advisor').prop "checked", true
        $('#user_advised_by').val ''
        $('#advisor_collapse')[0].toggle()
      else
        $('#actual_advisor').prop "checked", false
        $('#advisor_collapse')[0].toggle()
      return