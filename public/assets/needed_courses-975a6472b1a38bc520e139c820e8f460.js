(function() {
  jQuery(function() {
    $("#drawer_core_menu")[0].setAttribute("selected", "2");
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
