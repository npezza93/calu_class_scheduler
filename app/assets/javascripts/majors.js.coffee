# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    $("#drawer-menu")[0].setAttribute "selected", "3"

    if $("#majors-notice").find('paper-toast').length > 0
      document.getElementById('majors-notice-toast').toggle()
        
    $("#create-major").click ->
      $("#new_major").submit()
      $("#edit_major").submit()
      return

    $("#new_major_material").click ->
      document.location.href = '/majors/new'
      return

    $("#cancel_new_major").click ->
      window.history.back()
      return