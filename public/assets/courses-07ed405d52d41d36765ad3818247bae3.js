(function() {
  jQuery(function() {
    $("#drawer_core_menu")[0].setAttribute("selected", "1");
    $("#cancel_new_course").click(function() {
      window.history.back();
    });
    $("#material_create_course").click(function() {
      $("#actual_create_course")[0].click();
    });
    $("#material_update_course").click(function() {
      $("#actual_update_course")[0].click();
    });
    $("#course_select").val("-1");
    $("#course_dropdown").on("core-select", function(e, detail) {
      $("#course_select").val(e.originalEvent.detail.item.getAttribute("value"));
    });
    $("#day_select").val("-1");
    $("#day_dropdown").on("core-select", function(e, detail) {
      $("#day_select").val(e.originalEvent.detail.item.getAttribute("value"));
    });
    $("#advisor_select").val("-1");
    $("#advisor_dropdown").on("core-select", function(e, detail) {
      $("#advisor_select").val(e.originalEvent.detail.item.getAttribute("value"));
    });
    $("#material_offer_course").click(function() {
      $("#actual_offer_course")[0].click();
    });
    $("#new_course_material").click(function() {
      $("#new_course_link")[0].click();
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
