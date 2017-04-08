/*global $:true*/

$(document).on("turbolinks:load", function() {
  if ($(".schedule").length > 0) {
    $("[data-id]").each(function() {
      mergeClassRows($(this));
    })
  }
});

function mergeClassRows(td) {
  var id = td.data("id");
  var currentCol = td.index();
  var nextRow = td.closest("tr").index() + 1;
  var rowspans = $(".calendar td[rowspan]");

  rowspans.each(function () {
    var rsIndex = $(this).closest("tr").index();
    var rsQuantity = parseInt($(this).attr("rowspan"));
    if (nextRow > rsIndex && nextRow <= rsIndex + rsQuantity - 1) {
      currentCol--;
    }
  });

  var nextVert = $(".calendar tr").eq(nextRow).children().eq(currentCol);

  while (nextVert.data("id") == id) {
    td.attr("rowspan", (parseInt(td.attr("rowspan") || 1)) + 1);
    nextVert.remove();
    nextRow++;
    nextVert = $(".calendar tr").eq(nextRow).children().eq(currentCol);
  }
}
