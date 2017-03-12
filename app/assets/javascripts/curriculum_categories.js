$(document).on("turbolinks:load", function() {
  $.each($(".mdc-textfield"), function(index, element) {
    mdc.textfield.MDCTextfield.attachTo(element);
  });
  $.each($(".mdc-button"), function(index, element) {
    mdc.ripple.MDCRipple.attachTo(element);
  });
  $.each($(".mdc-fab"), function(index, element) {
    mdc.ripple.MDCRipple.attachTo(element);
  });
  $.each($(".mdc-ripple-surface"), function(index, element) {
    mdc.ripple.MDCRipple.attachTo(element);
  });
  $.each($(".mdc-select"), function(index, element) {
    mdc.select.MDCSelect.attachTo(element).listen('MDCSelect:change', function(e) {
      $(this).find("input[type='hidden']").val(e.detail.value);
    });
  });
  if ($(".mdc-snackbar").length > 0) {
    var snackbar = mdc.snackbar.MDCSnackbar.attachTo($(".mdc-snackbar")[0]);
    snackbar.show({ message: $(".mdc-snackbar").find(".mdc-snackbar__text").text() });
  }
  mdc.autoInit();
});

$(document).on("cocoon:after-insert", function(e, insertedItem) {
  mdc.autoInit();

  $.each($(".mdc-select"), function(index, element) {
    mdc.select.MDCSelect.attachTo(element).listen('MDCSelect:change', function(e) {
      $(this).find("input[type='hidden']").val(e.detail.value);
    });
  });

  $.each($(".mdc-button"), function(index, element) {
    mdc.ripple.MDCRipple.attachTo(element);
  });
  $.each($(".mdc-ripple-surface"), function(index, element) {
    mdc.ripple.MDCRipple.attachTo(element);
  });
});
