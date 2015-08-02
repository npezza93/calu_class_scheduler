(function() {
  jQuery(function() {
    return $("#password_reset_validation").click(function() {
      var error, not_blank;
      if ($("#user_password").val().length === 0) {
        $("#user_password").parent().attr("error", "Password can't be blank!");
        $("#user_password").parent()[0].isInvalid = true;
        not_blank = false;
      } else {
        $("#user_password").parent()[0].isInvalid = false;
        not_blank = true;
      }
      if ($("#user_password_confirmation").val().length === 0) {
        $("#user_password_confirmation").parent().attr("error", "Password confirmation can't be blank!");
        $("#user_password_confirmation").parent()[0].isInvalid = true;
        not_blank = false;
      } else {
        $("#user_password_confirmation").parent()[0].isInvalid = false;
        not_blank = true;
      }
      if (not_blank) {
        if ($("#user_password").val() !== $("#user_password_confirmation").val()) {
          $("#user_password_confirmation").parent().attr("error", "Password confirmation must match password!");
          $("#user_password_confirmation").parent()[0].isInvalid = true;
          error = true;
        }
        if ($("#user_password").val().length < 6) {
          $("#user_password").parent().attr("error", "Password must be at least 6 characters!");
          $("#user_password").parent()[0].isInvalid = true;
          error = true;
        }
        if (!error) {
          $("#submit_password_reset_update").click();
        }
      }
    });
  });

}).call(this);
