# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#drawer-menu")[0].setAttribute "selected", "5"

    $("#cancel_course_set_button").click ->
      window.history.back()
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