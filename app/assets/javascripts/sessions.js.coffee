$(document).on 'turbolinks:load', ->
  if $(".forgot_password_dialog").length > 0
    dialogPolyfill.registerDialog($(".forgot_password_dialog")[0])
    $("#forgot_password").click (e) ->
      e.preventDefault()
      $(".forgot_password_dialog")[0].showModal()
      return

  $(".close").click (e) ->
    $(this).closest("dialog")[0].close()
    return

  if $('.placement-test-dialog').length > 0
    dialogPolyfill.registerDialog($('.placement-test-dialog')[0])
    $('.placement-test-dialog-toggle').click ->
      $('.placement-test-dialog')[0].showModal()
      return
