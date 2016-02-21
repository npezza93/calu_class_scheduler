'use strict'
$(document).on 'turbolinks:load', ->
  e = undefined
  e = document.querySelectorAll('.getmdl-select')
  [].forEach.call e, (e) ->
    addEventListeners e
    return
  return

addEventListeners = (e) ->
  t = e.querySelector('input[type=text]')
  h = e.querySelector('input[type=hidden]')
  n = e.querySelectorAll('li')
  e.querySelector 'i'
  [].forEach.call n, (e) ->

    e.onclick = ->
      t.value = e.textContent
      h.value = e.value
      return

    return
  return

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
