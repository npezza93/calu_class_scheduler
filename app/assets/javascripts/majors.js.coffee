$(document).on 'turbolinks:load', ->
  $(".new_major_fab").click ->
    $(".new_major_dialog")[0].showModal()
