(function() {
  jQuery(function() {
    $("#submit_approval_paper_button").click(function() {
      $("#submit_approval_button")[0].click();
    });
    return $("#advisor_approve_schedule_button").click(function() {
      $("#advisor_approve_schedule_link")[0].click();
    });
  });

}).call(this);
