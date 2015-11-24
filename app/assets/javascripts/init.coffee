window.Whip ||= {}

Whip.init = ->
  $('[data-toggle="tooltip"]').tooltip()
  $('.issue_select').multiselect()

$(document).on "page:change", ->
  Whip.init()