(function() {
  jQuery(function() {
    $("#drawer-menu")[0].setAttribute("selected", "2");
    if ($("#offerings-notice").find('paper-toast').length > 0) {
      document.getElementById('offerings-notice-toast').toggle();
    }
    $("#new-offering-fab").click(function() {
      document.location.href = '/offerings/new';
    });
    $("#cancel_offering_button").click(function() {
      window.history.back();
    });
    $("#create-offering").click(function() {
      $("#new_offering").submit();
    });
    $("#offering_course_id").change(function() {
      if ($("#offering_course_id option:selected").val() !== "") {
        $("#offering_course_id").css("color", "#212121");
      } else {
        $("#offering_course_id").css("color", "#757575");
      }
    });
    $("#offering_days_time_id").change(function() {
      if ($("#offering_days_time_id option:selected").val() !== "") {
        $("#offering_days_time_id").css("color", "#212121");
      } else {
        $("#offering_days_time_id").css("color", "#757575");
      }
    });
    $("#offering_user_id").change(function() {
      if ($("#offering_user_id option:selected").val() !== "") {
        $("#offering_user_id").css("color", "#212121");
      } else {
        $("#offering_user_id").css("color", "#757575");
      }
    });
    $("#upload-fab").click(function() {
      $("#upload_offering_button")[0].click();
      $("#upload_offering_button").on("change", function() {
        $("#upload-offerings-form").submit();
      });
    });
    return $("#show-upload-offering-details").click(function() {
      var text;
      text = $('#show-upload-offering-details').text().trim();
      if (text === "Show Upload Details") {
        text = "Hide Upload Details";
      } else {
        text = "Show Upload Details";
      }
      $('#show-upload-offering-details').text(text);
      $("#upload-offering-details")[0].toggle();
    });
  });

}).call(this);
