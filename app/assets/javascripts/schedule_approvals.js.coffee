# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    
    $("#submit_approval_paper_button").click ->
      $("#submit_approval_button")[0].click()
      return
      
    $("#advisor_approve_schedule_button").click ->
      $("#advisor_approve_schedule_link")[0].click()
      return      