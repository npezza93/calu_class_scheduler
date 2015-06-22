(function() {
  jQuery(function() {
    $("#drawer-menu")[0].setAttribute("selected", "5");
    if ($("#categories-notice").find('paper-toast').length > 0) {
      document.getElementById('categories-notice-toast').toggle();
    }
    $("#new_category_material").click(function() {
      document.location.href = '/curriculum_categories/new';
    });
    $("#cancel_new_category").click(function() {
      window.history.back();
    });
    $("#create-category").click(function() {
      $("#new_curriculum_category").submit();
    });
    $('#major_paper_radio').on('change', function() {
      $('#curriculum_category_minor_true').prop('checked', false);
      $('#curriculum_category_minor_false').prop('checked', true);
    });
    $('#minor_paper_radio').on('change', function() {
      $('#curriculum_category_minor_false').prop('checked', false);
      $('#curriculum_category_minor_true').prop('checked', true);
    });
    $('#set_logic_and_paper_radio').on('change', function() {
      $('#curriculum_category_set_and_or_flag_true').prop('checked', false);
      $('#curriculum_category_set_and_or_flag_false').prop('checked', true);
      $('#curriculum_category_set_and_or_flag_0').prop('checked', false);
    });
    $('#set_logic_or_paper_radio').on('change', function() {
      $('#curriculum_category_set_and_or_flag_false').prop('checked', false);
      $('#curriculum_category_set_and_or_flag_true').prop('checked', true);
      $('#curriculum_category_set_and_or_flag_0').prop('checked', false);
    });
    $('#set_logic_na_paper_radio').on('change', function() {
      $('#curriculum_category_set_and_or_flag_false').prop('checked', false);
      $('#curriculum_category_set_and_or_flag_true').prop('checked', false);
      $('#curriculum_category_set_and_or_flag_0').prop('checked', true);
    });
    $("#update-category").click(function() {
      $(".edit_curriculum_category").submit();
    });
    return $("#continue-form-category").on('change', function() {
      if ($("#continue-form-category")[0].checked) {
        $("#continue").prop('checked', true);
        $("#create-category").html($("#create-category").html().split("Submit").join("Next"));
      } else {
        $("#continue").prop('checked', false);
        $("#create-category").html($("#create-category").html().split("Next").join("Submit"));
      }
    });
  });

}).call(this);
