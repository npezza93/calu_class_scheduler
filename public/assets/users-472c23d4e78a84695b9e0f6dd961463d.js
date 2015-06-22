(function() {
  jQuery(function() {
    var len, loc;
    len = location.pathname.split("/").length - 1;
    loc = location.pathname.split("/");
    if (loc[len] === "edit" && $("#new_user_password").length > 0) {
      $("#drawer-menu")[0].setAttribute("selected", "6");
    } else {
      $("#drawer-menu")[0].setAttribute("selected", "0");
    }
    if ($("#users-notice").find('paper-toast').length > 0) {
      document.getElementById('users-notice-toast').toggle();
    }
    $("#user_major_id").change(function() {
      if ($("#user_major_id option:selected").val() !== "") {
        $("#user_major_id").css("color", "#212121");
      } else {
        $("#user_major_id").css("color", "#757575");
      }
    });
    $("#user_advised_by").change(function() {
      if ($("#user_advised_by option:selected").val() !== "") {
        $("#user_advised_by").css("color", "#212121");
      } else {
        $("#user_advised_by").css("color", "#757575");
      }
    });
    $('#advisor_checkbox').change(function() {
      $('#advisor_collapse')[0].toggle();
      if ($('#advisor_checkbox')[0].checked) {
        $("#user_advised_by").css("color", "#757575");
        $('#actual_advisor').prop("checked", true);
        $('#user_advised_by').val('');
        $("#advisor_signup_dropdown_error_msg").fadeOut();
        $("#user_advised_by").removeClass("dropdown-error");
      } else {
        $('#actual_advisor').prop("checked", false);
      }
    });
    $("#cancel-edit-user").click(function() {
      window.history.back();
    });
    $('#advisee_signup_fab').click(function() {
      window.location.href = '/users/new';
    });
    return $("#update-advisor-of-user").click(function() {
      if ($("#advisor_checkbox")[0].checked) {
        $(".edit_user").submit();
      } else if ($("#user_advised_by").val() !== "") {
        $(".edit_user").submit();
      } else {
        $("#advisor_signup_dropdown_error_msg").fadeIn();
        $("#user_advised_by").addClass("dropdown-error");
      }
    });
  });

}).call(this);
