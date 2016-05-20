$(document).on 'turbolinks:load', ->
  componentHandler.upgradeDom()

  if $(".forgot_password_dialog").length > 0
    dialogPolyfill.registerDialog($(".forgot_password_dialog")[0])
    $("#forgot_password").click (e) ->
      e.preventDefault()
      $(".forgot_password_dialog")[0].showModal()
      return

  $(".close").click (e) ->
    $(this).parent().parent().parent()[0].close()
    return

  if $("#notice").length > 0
    data =
      message: $(".mdl-snackbar__text").text()
      timeout: 2000
    $("#notice")[0].MaterialSnackbar.showSnackbar data
