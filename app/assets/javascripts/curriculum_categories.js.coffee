# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
    # $("#drawer-menu")[0].setAttribute "selected", "5"
$(document).on "cocoon:after-insert", (e, insertedItem) ->
  select = insertedItem.find(".getmdl-select")
  menu = insertedItem.find(".mdl-menu")
  random = Math.random().toString(36).substr(2)
  select.find("[for]").attr("for", random)
  select.find(".mdl-textfield__input").attr("id", random)
  if select.length
    componentHandler.upgradeElement(select[0])
    componentHandler.upgradeElement(menu[0])
  componentHandler.upgradeElement($("div.mdl-textfield.mdl-js-textfield").last()[0])
  e = document.querySelectorAll('.getmdl-select')
  [].forEach.call e, (e) ->
    addEventListeners e
    return
  return

addEventListeners = (e) ->
  t = e.querySelector("input[type=text]")
  n = e.querySelectorAll('li')
  e.querySelector 'i'
  [].forEach.call n, (e) ->

    e.onclick = ->
      t.value = e.textContent
      return

    return
  return
