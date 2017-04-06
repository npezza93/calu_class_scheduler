/*global $:true*/

$(document).on("turbolinks:load", function() {
  if ($(".schedule").length > 0) {
    $("[data-id]").each(function() {
      expandClassRow($(this));
    })
  }
});

function expandClassRow(element) {
  var td = element;
  var id = element.data("id");

  var currentCol = td.index();
  var nextRow = td.closest("tr").index() + 1;
  var rowspans = $(".calendar td[rowspan]");

  rowspans.each(function () {
      var rs = $(this);
      var rsIndex = rs.closest("tr").index();
      var rsQuantity = parseInt(rs.attr("rowspan"));
      if (nextRow > rsIndex && nextRow <= rsIndex + rsQuantity - 1) {
          currentCol--;
      }
  });

  var nextVert = $(".calendar tr").eq(nextRow).children().eq(currentCol);

  if (nextVert.data("id") == id) {
    td.attr("rowspan", (td.attr("rowspan") || 1) + 1);
    nextVert.remove();
  }
}
