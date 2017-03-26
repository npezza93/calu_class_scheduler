$(document).on("click", ".upload-offerings", function(e) {
  e.preventDefault();
  var dialog = mdc.dialog.MDCDialog.attachTo($("#upload-offerings-dialog")[0]);
  dialog.lastFocusedTarget = e.target;
  dialog.show();
});

$(document).on("click", ".choose-file", function(e) {
  e.preventDefault();
  $("#offering_file").click();
});

$(document).on("change", "#offering_file", function() {
  this.parentNode.submit();
});
