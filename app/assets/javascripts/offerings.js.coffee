# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    
    $("#new_offerings_material").click ->
        $("#new_offerings_link")[0].click()
        return

    $("#course_dropdown").on "core-select", (e, detail) ->
      $("#offering_course_id").val e.originalEvent.detail.item.getAttribute("value")
      return

    $("#day_dropdown").on "core-select", (e, detail) ->
      $("#offering_days_time_id").val e.originalEvent.detail.item.getAttribute("value")
      return      

    $("#advisor_dropdown").on "core-select", (e, detail) ->
      $("#offering_user_id").val e.originalEvent.detail.item.getAttribute("value")
      return

    $("#upload-fab").click ->
      $("#offering_overlay")[0].toggle();
      return
      
    $("#material_upload_offerings").click ->
      $("#upload_offering_button")[0].click()
      $("#upload_offering_button").on "change", ->
        $("#submit_upload_offering_button")[0].click()
        return
      return
      
    $("#cancel_upload_offering").click ->
      $("#offering_overlay")[0].toggle();
      return  
      