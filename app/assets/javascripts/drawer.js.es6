/*global Turbolinks $:true*/

$(document).on("click", "#drawer a", function(e) {
  e.preventDefault();
  $("#drawer a.active").toggleClass("active");
  $(this).toggleClass("active");
  Turbolinks.visit($(this).attr("href"));
});
