(function() {
  jQuery(function() {
    $("#drawer_core_menu")[0].setAttribute("selected", "6");
    $("#submit_category_class_material").click(function() {
      var decorator, input;
      decorator = $('#count_decorator')[0];
      input = $('#count')[0];
      decorator.isInvalid = !input.validity.valid;
      if ($("#course_id option:selected").length === 0) {
        $("#cc_set_dropdown_error_msg").fadeIn();
        $(".category_course_set_select").css("border-bottom", "1px solid #d34336");
      } else {
        $("#cc_set_dropdown_error_msg").fadeOut();
        $(".category_course_set_select").css("border-bottom", "1px solid #757575");
      }
      if (!decorator.isInvalid && $("#course_id option:selected").length !== 0) {
        $("#submit_category_class_button")[0].click();
      }
    });
    $("#submit_edit_set_material").click(function() {
      var decorator, input;
      decorator = $('#count_decorator')[0];
      input = $('#curriculum_category_set_count')[0];
      decorator.isInvalid = !input.validity.valid;
      if ($("#course_id option:selected").length === 0) {
        $("#cc_set_dropdown_error_msg").fadeIn();
        $(".category_course_set_select").css("border-bottom", "1px solid #d34336");
      } else {
        $("#cc_set_dropdown_error_msg").fadeOut();
        $(".category_course_set_select").css("border-bottom", "1px solid #757575");
      }
      if (!decorator.isInvalid && $("#course_id option:selected").length !== 0) {
        $("#submit_category_class_button")[0].click();
      }
    });
    $('#set_logic_and_paper_radio').on('change', function() {
      $('#curriculum_category_set_and_or_flag_true').prop('checked', false);
      $('#curriculum_category_set_and_or_flag_false').prop('checked', true);
      $("#submit_and_or_flag")[0].click();
    });
    $('#set_logic_or_paper_radio').on('change', function() {
      $('#curriculum_category_set_and_or_flag_false').prop('checked', false);
      $('#curriculum_category_set_and_or_flag_true').prop('checked', true);
      $("#submit_and_or_flag")[0].click();
    });
    $("#course_dropdown").on("core-select", function(e) {
      $("#course_select").val(e.originalEvent.detail.item.getAttribute("value"));
    });
    $("#logic_flag_toggle").on("change", function(e) {
      return $("#logic_flag")[0].checked = $("#logic_flag_toggle")[0].checked;
    });
    $("#cancel_new_set").click(function() {
      $("#category_index_link")[0].click();
    });
    $("#cancel_edit_set").click(function() {
      $("#category_set_index_link")[0].click();
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
