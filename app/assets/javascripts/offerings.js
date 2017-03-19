$(document).on("click", ".upload-offerings", function(e) {
  e.preventDefault();
  $("#upload-offerings-dialog")[0].show();
});

$(document).on("click", ".choose-file", function(e) {
  e.preventDefault();
  $("#offering_file").click();
});

$(document).on("change", "#offering_file", function() {
  this.parentNode.submit();
});

$(document).on("click", ".close", function(e) {
  e.preventDefault();
  $(this).closest("dialog")[0].close();
});
