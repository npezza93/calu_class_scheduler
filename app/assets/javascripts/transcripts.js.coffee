# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  
    $("#transcript_course_select").val "-1"
    $("#transcript_course_dropdown").on "core-select", (e, detail) ->
      $("#transcript_course_select").val e.originalEvent.detail.item.getAttribute("value")
      return
      
    $("#grade_select").val "-1"
    $("#grade_dropdown").on "core-select", (e, detail) ->
      $("#grade_select").val e.originalEvent.detail.item.getAttribute("value")
      return
      
    $("#submit_taken_class_material").click ->
      $("#submit_taken_class_button")[0].click()
      return