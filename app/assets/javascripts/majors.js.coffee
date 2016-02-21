$(document).on 'turbolinks:load', ->
  # $("#drawer-menu")[0].setAttribute "selected", "3"
  $(".new_major_fab").click ->
    $(".new_major_dialog")[0].showModal()
