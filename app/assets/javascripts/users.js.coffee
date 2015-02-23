# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $('#paper_advisor').change ->
      document.getElementById('actual_advisor').checked = document.getElementById('paper_advisor').checked
      if document.getElementById('paper_advisor').checked
        $('#user_advised_by').val '-1'
        document.getElementById('advisor_dropdown_menu').setAttribute 'disabled', ''
        document.getElementById('advisor_collapse').toggle()
      else
        $('#user_advised_by').val $($('#advisor_core_menu')[0].selectedItem).attr('value')
        document.getElementById('advisor_dropdown_menu').removeAttribute 'disabled', ''
        document.getElementById('advisor_collapse').toggle()
      return

    $("#drawer_core_menu")[0].setAttribute "selected", "0"

    $("#cancel_user_button").click ->
      window.history.back()
      return   
    
    $("#actual_select").val "-1"
    $("#advisor_dropdown").on "core-select", (e, detail) ->
      $("#actual_select").val e.originalEvent.detail.item.getAttribute("value")
      return
    
    $("#actual_major_select").val "-1"
    $("#major_dropdown").on "core-select", (e, detail) ->
      $("#actual_major_select").val e.originalEvent.detail.item.getAttribute("value")
      $("#user_major_id").val e.originalEvent.detail.item.getAttribute("value")
      return

    $("#advisor_dropdown").on "core-select", (e, detail) ->
      $("#actual_select_edit_advisor").val e.originalEvent.detail.item.getAttribute("value")
      return

    $("#pagination-item").click ->
      $("#link_to_next_page").find("#next_link").click()
      return
    
    $("#pagination2-item").click ->
      $("#link_to_next_page2").find("#next_link").click()
      return

    $("#pagination3-item").click ->
      $("#link_to_next_page3").find("#next_link").click()
      return
      
    $('#advisee_signup_fab').click ->
      $('#signup_fab_link')[0].click()
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