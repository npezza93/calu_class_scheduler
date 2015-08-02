(function() {
  jQuery(function() {
    $("#drawer-menu")[0].setAttribute("selected", "4");
    if ($("#semesters-notice").find('paper-toast').length > 0) {
      document.getElementById('semesters-notice-toast').toggle();
    }
    $("#create-semester").click(function() {
      $("#new_semester").submit();
    });
    $("#semester_active").on("change", function() {
      $(".edit_semester").submit();
    });
    $("#new_semester_material").click(function() {
      document.location.href = '/semesters/new';
    });
    return $("#cancel_new_semester").click(function() {
      window.history.back();
    });
  });

}).call(this);
