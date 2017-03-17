$(document).on("turbolinks:load", function() {
  $(".upload-offerings").click(function(e) {
    e.preventDefault();
    $("#upload-offerings-dialog")[0].showModal();
    return;
  });

  $(".choose-file").click(function(e) {
    e.preventDefault();
    $("#offering_file").click();
    return;
  });

  $("#offering_file").on("change", function() {
    $(this).parent().submit();
    return;
  });
});
