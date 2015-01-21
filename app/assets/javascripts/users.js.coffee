# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#actual_select").val "-1"
    $("#advisor_dropdown").on "core-select", (e, detail) ->
      $("#actual_select").val e.originalEvent.detail.item.getAttribute("value")
      return
    
    $("#actual_major_select").val "-1"
    $("#major_dropdown").on "core-select", (e, detail) ->
      $("#actual_major_select").val e.originalEvent.detail.item.getAttribute("value")
      return

    $("#advisor_dropdown").on "core-select", (e, detail) ->
      $("#actual_select_edit_advisor").val e.originalEvent.detail.item.getAttribute("value")
      return

    $("#pagination-item").click ->
      $("#link_to_next_page").find("#next_link").click()
      return
    
    $("#pagination2-item").click ->
      $("#link_to_next_page2").find("#next_link").click()
      return