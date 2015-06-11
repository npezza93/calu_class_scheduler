# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#drawer-menu")[0].setAttribute "selected", "5"

    if $("#category-sets-notice").find('paper-toast').length > 0
      document.getElementById('category-sets-notice-toast').toggle()

    if $("#course-sets-notice").find('paper-toast').length > 0
      document.getElementById('course-sets-notice-toast').toggle()

    $("#cancel-new-edit-set").click ->
      location = document.location.pathname.split("/")
      if location.pop() == "edit"
        location.pop()
      document.location.href = location.join("/")
      return

    $("#new-course-fab").click ->
      document.location.href = document.location.pathname + "/new"
      return

    $("#create-set").click ->
      if $("#new_curriculum_category_set").length > 0
        $("#new_curriculum_category_set").submit()
      else
        $(".edit_curriculum_category_set").submit()
      return

    $("#new-course-set-fab").click ->
      document.location.href = document.location.pathname + "/course_sets/new"
      return
