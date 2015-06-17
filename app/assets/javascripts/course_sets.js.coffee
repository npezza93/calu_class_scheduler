# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#drawer-menu")[0].setAttribute "selected", "5"

    if $("#course-set-notice").find('paper-toast').length > 0
      document.getElementById('course-set-notice-toast').toggle()

    $("#cancel_course_set_button").click ->
      loc = document.location.href.split("/")
      loc.pop()
      loc.pop()
      document.location.href = loc.join("/")
      return

    $("#create-course-set").click ->
    	if $("#course_set_course_id option:selected").val() == ""
        	$("#course_set_course_id").addClass("dropdown-error")
    	else
        	$("#course_set_course_id").removeClass("dropdown-error")

    	if $("#course_set_course_id option:selected").val() == ""
        	$("#course_set_error_msg").fadeIn()
    	else
        	$("#course_set_error_msg").fadeOut()
        	$("#new_course_set").submit()
    	return

    $("#course_set_course_id").change ->
      if $("#course_set_course_id option:selected" ).val() != ""
        $("#course_set_course_id" ).css "color", "#212121"
      else
        $("#course_set_course_id" ).css "color", "#757575"
      return

    $("#continue-form-set").on 'change', ->
      if $("#continue-form-set")[0].checked
        $("#continue").prop 'checked', true
        $("#create-set").html($("#create-set").html().split("Submit").join("Next"))
      else
        $("#continue").prop 'checked', false
        $("#create-set").html($("#create-set").html().split("Next").join("Submit"))
      return