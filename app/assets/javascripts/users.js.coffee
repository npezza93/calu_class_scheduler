$(document).on 'turbolinks:load', ->
  $("#search").keyup ->
    $("#search").parent().parent().submit()

  $("#search").on 'focus', ->
    if (this.setSelectionRange)
      len = $(this).val().length * 2
      this.setSelectionRange(len, len)
    else
      $(this).val($(this).val())
    return
