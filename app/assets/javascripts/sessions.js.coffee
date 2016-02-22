$(document).on 'turbolinks:load', ->
  componentHandler.upgradeDom()

  $("#forgot_password").click (e) ->
    e.preventDefault()
    $(".forgot_password_dialog")[0].showModal()
    return

  $(".close").click (e) ->
    $(this).parent().parent().parent()[0].close();
    return

  if $("#notice").length
    $("#notice")[0].MaterialSnackbar.showSnackbar message: $(".mdl-snackbar__text").text()
