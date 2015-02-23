# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#drawer_core_menu")[0].setAttribute "selected", "1"

    $("#cancel_new_course").click ->
      window.history.back()
      return    
    
    $("#material_create_course").click ->
      $("#actual_create_course")[0].click()
      return

    $("#material_update_course").click ->
      $("#actual_update_course")[0].click()
      return
      
    $("#course_select").val "-1"
    $("#course_dropdown").on "core-select", (e, detail) ->
      $("#course_select").val e.originalEvent.detail.item.getAttribute("value")
      return
    
    $("#day_select").val "-1"
    $("#day_dropdown").on "core-select", (e, detail) ->
      $("#day_select").val e.originalEvent.detail.item.getAttribute("value")
      return
    
    $("#advisor_select").val "-1"
    $("#advisor_dropdown").on "core-select", (e, detail) ->
      $("#advisor_select").val e.originalEvent.detail.item.getAttribute("value")
      return
    
    $("#material_offer_course").click ->
      $("#actual_offer_course")[0].click()
      return

    $("#new_course_material").click ->
        $("#new_course_link")[0].click()
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

    $("#drawer_choose_minor_item_baluga").click ->
      $("#choose_minor_overlay")[0].toggle()
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

    $("#drawer_needed_course_item").click ->
      $("#needed_course_link")[0].click()
      return
    
    $("#drawer_users_item").click ->
      $("#users_link")[0].click()
      return
    
    $("#drawer_categories_item").click ->
      $("#categories_link")[0].click()
      return