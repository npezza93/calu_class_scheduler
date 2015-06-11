# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#drawer-menu")[0].setAttribute "selected", "4"

    if $("#semesters-notice").find('paper-toast').length > 0
      document.getElementById('semesters-notice-toast').toggle()
    
    $("#create-semester").click ->
        $("#new_semester").submit()
        return

    $("#semester_active").on "change", ->
      $(".edit_semester").submit()
      return
    
    $("#new_semester_material").click ->
        document.location.href = '/semesters/new'
        return

    $("#cancel_new_semester").click ->
      window.history.back()
      return