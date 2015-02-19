# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#drawer_core_menu")[0].setAttribute "selected", "6"


    $("#new_category_material").click ->
        $("#new_cc_overlay")[0].toggle()
        return

    $("#material_create_category").click ->
      $("#actual_create_category")[0].click()
      return

    $('#major_paper_radio').on 'change', ->
      $('#curriculum_category_minor_true').prop 'checked', false
      $('#curriculum_category_minor_false').prop 'checked', true
      return
      
    $('#minor_paper_radio').on 'change', ->
      $('#curriculum_category_minor_false').prop 'checked', false
      $('#curriculum_category_minor_true').prop 'checked', true
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