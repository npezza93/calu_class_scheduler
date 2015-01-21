# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $("#forgot_password").click ->
        document.getElementById('overlay3').toggle()
        
    $("#one").click (e) ->
      $("#baluga")[0].selected = 0
      return

    
    $("#two").click (e) ->
      $("#baluga")[0].selected = 1
      return