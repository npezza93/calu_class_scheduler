/*global $:true*/

$(document).on("turbolinks:load", function() {
  $(document).on("click", "#drawer a", function() {
    $("#drawer a.active").removeClass("active");
    $(this).addClass("active");
  });
});
