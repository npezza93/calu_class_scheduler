# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#material_create_course").click ->
      $("#actual_create_course")[0].click()
      return

    $("#material_update_course").click ->
      $("#actual_update_course")[0].click()
      return
      
    $("#course_select").val "-1"
    $("#course_dropdown").on "core-select", (e, detail) ->
      $("#course_select").val e.originalEvent.detail.item.getAttribute("value")
      return
    
    $("#day_select").val "-1"
    $("#day_dropdown").on "core-select", (e, detail) ->
      $("#day_select").val e.originalEvent.detail.item.getAttribute("value")
      return
    
    $("#advisor_select").val "-1"
    $("#advisor_dropdown").on "core-select", (e, detail) ->
      $("#advisor_select").val e.originalEvent.detail.item.getAttribute("value")
      return
    
    $("#material_offer_course").click ->
      $("#actual_offer_course")[0].click()
      return

    $("#new_course_material").click ->
        $("#new_course_link")[0].click()
        return