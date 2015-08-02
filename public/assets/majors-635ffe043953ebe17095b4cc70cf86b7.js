(function() {
  jQuery(function() {
    $("#drawer-menu")[0].setAttribute("selected", "3");
    if ($("#majors-notice").find('paper-toast').length > 0) {
      document.getElementById('majors-notice-toast').toggle();
    }
    $("#create-major").click(function() {
      $("#new_major").submit();
      $("#edit_major").submit();
    });
    $("#new_major_material").click(function() {
      document.location.href = '/majors/new';
    });
    return $("#cancel_new_major").click(function() {
      window.history.back();
    });
  });

}).call(this);
