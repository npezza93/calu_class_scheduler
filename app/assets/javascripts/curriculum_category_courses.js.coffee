# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#submit_category_class_material").click ->
        $("#submit_category_class_button")[0].click()
        return
    
    $("#course_select").val "-1"
    
    $("#course_dropdown").on "core-select", (e) ->
        $("#course_select").val e.originalEvent.detail.item.getAttribute("value")
        return
