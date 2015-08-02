(function() {
  jQuery(function() {
    $(document).load(function() {
      if ($("#session-notice").find('paper-toast').length > 0) {
        $("#session-notice").find('paper-toast')[0].toggle();
      }
      $("#new_session_overlay")[0].center();
    });
    $("#forgot_password").click(function() {
      return document.getElementById('forgot-dialog').toggle();
    });
    $("#one").click(function(e) {
      if ($("#paperTabs")[0].selected !== "0") {
        $("#baluga")[0].selected = 0;
        $("#baluga").attr('entry-animation', 'slide-from-right-animation');
        $("#baluga").attr('exit-animation', 'slide-left-animation');
      }
    });
    $("#two").click(function(e) {
      $("#baluga")[0].selected = 1;
      $("#baluga").attr('entry-animation', 'slide-from-left-animation');
      $("#baluga").attr('exit-animation', 'slide-right-animation');
    });
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
    return $('#advisor_checkbox').change(function() {
      if ($('#advisor_checkbox')[0].checked) {
        $('#actual_advisor').prop("checked", true);
        $('#user_advised_by').val('');
        $('#advisor_collapse')[0].toggle();
      } else {
        $('#actual_advisor').prop("checked", false);
        $('#advisor_collapse')[0].toggle();
      }
    });
  });

}).call(this);
