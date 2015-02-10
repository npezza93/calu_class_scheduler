# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#fab_new_schedule").click ->
        $("#new_schedule_modal")[0].toggle()
        return
    
    $("#media_query_schedule").on "core-media-change", (e) ->
      if e.originalEvent.detail.matches is true
        $("#big_schedule_table")[0].setAttribute "hidden", ""
        $("#small_schedule_table")[0].removeAttribute "hidden", ""
        $(".small_schedule_course_title").removeAttr "hidden", ""
      else
        $("#big_schedule_table")[0].removeAttribute "hidden", ""
        $("#small_schedule_table")[0].setAttribute "hidden", ""
        $(".small_schedule_course_title").attr "hidden", ""
      return
      
    $("#media_query_schedule_new").on "core-media-change", (e) ->
      console.log("hi")
      if e.originalEvent.detail.matches is true
        $(".new_schedule_headers").attr "hidden", ""
        $(".new_schedule_credit_td").attr "hidden", ""
        $(".new_schedule_times_td").attr "hidden", ""
        $(".new_schedule_prof_td").attr "hidden", ""
        $(".new_schedule_nc_td").attr "hidden", ""
        $(".new_schedule_check_td").attr "rowspan", 2
        $(".new_schedule_course_td").attr "rowspan", 2
        $(".new_schedule_day_times_td").removeAttr "hidden"
        $(".resp_new_schedule_tr").removeAttr "hidden"
        $(".common_tr").attr "hidden", ""
      else
        $(".resp_new_schedule_tr").attr "hidden", ""
        $(".new_schedule_credit_td").removeAttr "hidden", ""
        $(".new_schedule_times_td").removeAttr "hidden", ""
        $(".new_schedule_prof_td").removeAttr "hidden", ""
        $(".new_schedule_nc_td").removeAttr "hidden", ""
        $(".new_schedule_headers").removeAttr "hidden", ""
        $(".new_schedule_check_td").removeAttr "rowspan"
        $(".new_schedule_course_td").removeAttr "rowspan"
        $(".new_schedule_day_times_td").attr "hidden", ""
        $(".common_tr").removeAttr "hidden"
      return
      
    $(".offering_checkbox").click (e) ->
      id_string = "#schedule_new_actual_select option[value=" + e.currentTarget.id + "]"
      if $("#schedule_new_actual_select")[0].options[$(id_string).index()].selected
        $("#schedule_new_actual_select")[0].options[$(id_string).index()].selected = false
      else
        $("#schedule_new_actual_select")[0].options[$(id_string).index()].selected = true
      $("#submit_schedule_changes")[0].click()
      return

    $("#drawer_transcripts_item_baluga").click ->
      $("#baluga3")[0].selected = 0
      $("core-drawer-panel")[0].closeDrawer();
      return
    
    $("#drawer_schedule_item_baluga").click ->
      $("#baluga3")[0].selected = 1
      $("core-drawer-panel")[0].closeDrawer();
      return
    
    $("#drawer_new_schedule_item_baluga").click ->
      $("#baluga3")[0].selected = 2
      $("core-drawer-panel")[0].closeDrawer();
      return
      
    $("#drawer_change_password_item_baluga").click ->
      $("#change_password_overlay")[0].toggle()
      return     

    $("#drawer_transcripts_item").click ->
      $("#user_transcripts_app_link")[0].click()
      return
    
    $("#drawer_schedule_item").click ->
      $("#user_schedules_app_link")[0].click()
      return
    
    $("#drawer_new_schedule_item").click ->
      $("#new_user_schedule_app_link")[0].click()
      return
    
    
    $("#drawer_logout_item").click ->
      $("#logout_button")[0].click()
      return
    
    $("#drawer_change_password_item").click ->
      $("#change_password_link")[0].click()
      return
    
    $("#drawer_new_major_item").click ->
      $("#new_major_link")[0].click()
      return

    $("#drawer_semesters_item").click ->
      $("#semesters_link")[0].click()
      return
      
    $("#drawer_offerings_item").click ->
      $("#offerings_link")[0].click()
      return
    
    $("#drawer_course_item").click ->
      $("#delete_course_link")[0].click()
      return
    
    $("#drawer_users_item").click ->
      $("#users_link")[0].click()
      return
    
    $("#drawer_categories_item").click ->
      $("#categories_link")[0].click()
      return

    $("#change_password_overlay").on "core-overlay-close-completed", (e) ->
      $("#drawer_core_menu")[0].selected= ($("#baluga3")[0].selected * 2)
      $("#user_password").parent().attr "error", ""
      $("#user_password").parent().attr "isInvalid", "false"
      $("#user_password_confirmation").parent().attr "error", ""
      $("#user_password_confirmation").parent().attr "isInvalid", "false"
      $("#user_password").val("");
      $("#user_password_confirmation").val("");
      $("#user_password").parent()[0].updateLabelVisibility();
      $("#user_password_confirmation").parent()[0].updateLabelVisibility();
      return
      
    $("#upload_transcript_button").click ->
      $("#upload_transcript_link")[0].click()
      $("#upload_transcript_link").on "change", ->
        $("#submit_upload_transcript_button")[0].click()
        return
    
      return