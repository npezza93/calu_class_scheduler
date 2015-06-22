(function() {
  jQuery(function() {
    $("#drawer-menu")[0].setAttribute("selected", "5");
    if ($("#category-sets-notice").find('paper-toast').length > 0) {
      document.getElementById('category-sets-notice-toast').toggle();
    }
    if ($("#course-sets-notice").find('paper-toast').length > 0) {
      document.getElementById('course-sets-notice-toast').toggle();
    }
    $("#cancel-new-edit-set").click(function() {
      var location;
      location = document.location.pathname.split("/");
      if (location.pop() === "edit") {
        location.pop();
      }
      document.location.href = location.join("/");
    });
    $("#new-course-fab").click(function() {
      document.location.href = document.location.pathname + "/new";
    });
    $("#create-set").click(function() {
      if ($("#new_curriculum_category_set").length > 0) {
        $("#new_curriculum_category_set").submit();
      } else {
        $(".edit_curriculum_category_set").submit();
      }
    });
    $("#new-course-set-fab").click(function() {
      document.location.href = document.location.pathname + "/course_sets/new";
    });
    return $("#continue-form-set").on('change', function() {
      if ($("#continue-form-set")[0].checked) {
        $("#continue").prop('checked', true);
        $("#create-set").html($("#create-set").html().split("Submit").join("Next"));
      } else {
        $("#continue").prop('checked', false);
        $("#create-set").html($("#create-set").html().split("Next").join("Submit"));
      }
    });
  });

}).call(this);
