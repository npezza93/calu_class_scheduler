# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#drawer-menu")[0].setAttribute "selected", "1"

    if $("#courses-notice").find('paper-toast').length > 0
      document.getElementById('courses-notice-toast').toggle()

    $("#cancel_new_course").click ->
      window.history.back()
      return    
    
    $("#new-course-fab").click ->
      document.location.href = "/courses/new"
      return

    $("#course_minimum_pt").change ->
      if $("#course_minimum_pt option:selected" ).val() != ""
        $("#course_minimum_pt" ).css "color", "#212121"
      else
        $("#course_minimum_pt " ).css "color", "#757575"
      return

    $("#course_minimum_class_standing").change ->
      if $("#course_minimum_class_standing option:selected" ).val() != ""
        $("#course_minimum_class_standing" ).css "color", "#212121"
      else
        $("#course_minimum_class_standing " ).css "color", "#757575"
      return

    $("#course_minimum_sat_score").change ->
      if $("#course_minimum_sat_score option:selected" ).val() != ""
        $("#course_minimum_sat_score" ).css "color", "#212121"
      else
        $("#course_minimum_sat_score " ).css "color", "#757575"
      return      
    
    $("#add-or-group").click (max_group_id) ->
      max_group_id = $("#prereq_groups").find('select').length
      prereq_string = "<div class='layout horizontal center-justified'style='font-size: 16px;font-weight: bold;'> - OR -</div><div class='course_prereq_group " + (max_group_id + 1) + " layout vertical'><label>Group " + (max_group_id + 1) + "</label>"
      prereq_string += $($(".actual_select_courses")[0]).clone().prop('outerHTML')
      $("#prereq_groups").append(prereq_string)
      return

    $("#prereq_min_grades").on "change", "select", ->
      string = ""
      $(".prereq_grades_dropdown option:selected").each ->
          string += $(this).text() + "/|/"
          return
      $("#prereq_grades").val(string)
      return

    $("#minimum_grades").change ->
      if $("#minimum_grades option:selected" ).val() != ""
        $("#minimum_grades" ).css "color", "#212121"
      else
        $("#minimum_grades " ).css "color", "#757575"
      return

    $("#prereq_groups").on "change",  "select", ->
      $("#prereq_min_grades").html("")
      $(".actual_select_courses option:selected").each ->
        temp_str = "<div class='layout horizontal' style='font-size: 16px;margin-top:5px;margin-bottom:5px;'><div class='flex course-min-grade'>" + $(this).text() + "</div><div>"
        temp_str += $("#minimum_grades").clone().removeClass("copy-min-grades").addClass("prereq_grades_dropdown").removeAttr("hidden", "").prop('outerHTML')
        temp_str += "</div></div>"
        $("#prereq_min_grades").append(temp_str)

      string = ""
      $(".prereq_grades_dropdown option:selected").each ->
        string += $(this).text() + "/|/"

      $("#prereq_grades").val(string)
      return

    $("#create-course").click ->
      $("#new_course").submit()
      return

    $("#update-course").click ->
      $(".edit_course").submit()
      return