# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#material_create_semester").click ->
        $("#actual_create_semester").click()
        return

    $("#semester_dropdown").on "core-select", (e, detail) ->
      $("#semester_active").val e.originalEvent.detail.item.getAttribute("value")
      $("#submit_active_semester")[0].click()
      return
    
    $("#new_semester_material").click ->
        $("#new_semester_overlay")[0].toggle()
        return