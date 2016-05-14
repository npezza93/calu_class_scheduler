$(document).on 'turbolinks:load', ->
  $(".input-field select").material_select()

$(document).on "cocoon:after-insert", (e, insertedItem) ->
  $(".input-field select").material_select()
