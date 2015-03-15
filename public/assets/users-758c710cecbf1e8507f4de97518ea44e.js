(function() {
  jQuery(function() {
    $('#advisor_dropdown').on('core-select', function(e, detail) {
      $('#actual_select_edit_advisor').val(e.originalEvent.detail.item.getAttribute('value'));
      $('#user_advised_by').val(e.originalEvent.detail.item.getAttribute('value'));
    });
    $("#major_dropdown").on("core-select", function(e, detail) {
      $("#user_major_id").val(e.originalEvent.detail.item.getAttribute("value"));
    });
    $('#paper_advisor').change(function() {
      document.getElementById('actual_advisor').checked = document.getElementById('paper_advisor').checked;
      if (document.getElementById('paper_advisor').checked) {
        $('#user_advised_by').val('-1');
        document.getElementById('advisor_dropdown_menu').setAttribute('disabled', '');
        document.getElementById('advisor_collapse').toggle();
      } else {
        $('#user_advised_by').val($($('#advisor_core_menu')[0].selectedItem).attr('value'));
        document.getElementById('advisor_dropdown_menu').removeAttribute('disabled', '');
        document.getElementById('advisor_collapse').toggle();
      }
    });
    if ($("#drawer_core_menu").length !== 0) {
      $("#drawer_core_menu")[0].setAttribute("selected", "0");
    }
    $("#cancel_user_button").click(function() {
      window.history.back();
    });
    $("#pagination-item").click(function() {
      $("#link_to_next_page").find("#next_link").click();
    });
    $("#pagination2-item").click(function() {
      $("#link_to_next_page2").find("#next_link").click();
    });
    $("#pagination3-item").click(function() {
      $("#link_to_next_page3").find("#next_link").click();
    });
    $('#advisee_signup_fab').click(function() {
      $('#signup_fab_link')[0].click();
    });
    $("#drawer_transcripts_item_baluga").click(function() {
      $("#baluga3")[0].selected = 0;
      $("core-drawer-panel")[0].closeDrawer();
    });
    $("#drawer_schedule_item_baluga").click(function() {
      $("#baluga3")[0].selected = 1;
      $("core-drawer-panel")[0].closeDrawer();
    });
    $("#drawer_new_schedule_item_baluga").click(function() {
      $("#baluga3")[0].selected = 2;
      $("core-drawer-panel")[0].closeDrawer();
    });
    $("#drawer_choose_minor_item_baluga").click(function() {
      $("#choose_minor_overlay")[0].toggle();
    });
    $("#drawer_change_password_item_baluga").click(function() {
      $("#change_password_overlay")[0].toggle();
    });
    $("#drawer_transcripts_item").click(function() {
      $("#user_transcripts_app_link")[0].click();
    });
    $("#drawer_schedule_item").click(function() {
      $("#user_schedules_app_link")[0].click();
    });
    $("#drawer_new_schedule_item").click(function() {
      $("#new_user_schedule_app_link")[0].click();
    });
    $("#drawer_logout_item").click(function() {
      $("#logout_button")[0].click();
    });
    $("#drawer_change_password_item").click(function() {
      $("#change_password_link")[0].click();
    });
    $("#drawer_new_major_item").click(function() {
      $("#new_major_link")[0].click();
    });
    $("#drawer_semesters_item").click(function() {
      $("#semesters_link")[0].click();
    });
    $("#drawer_offerings_item").click(function() {
      $("#offerings_link")[0].click();
    });
    $("#drawer_course_item").click(function() {
      $("#delete_course_link")[0].click();
    });
    $("#drawer_needed_course_item").click(function() {
      $("#needed_course_link")[0].click();
    });
    $("#drawer_users_item").click(function() {
      $("#users_link")[0].click();
    });
    return $("#drawer_categories_item").click(function() {
      $("#categories_link")[0].click();
    });
  });

}).call(this);
