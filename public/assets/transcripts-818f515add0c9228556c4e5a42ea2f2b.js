(function() {
  jQuery(function() {
    $("#transcript_course_select").val("-1");
    $("#transcript_course_dropdown").on("core-select", function(e, detail) {
      $("#transcript_course_select").val(e.originalEvent.detail.item.getAttribute("value"));
    });
    $("#grade_select").val("-1");
    $("#grade_dropdown").on("core-select", function(e, detail) {
      $(".grade_select").val(e.originalEvent.detail.item.getAttribute("value"));
    });
    return $("#submit_taken_class_material").click(function() {
      $("#submit_taken_class_button")[0].click();
    });
  });

}).call(this);
