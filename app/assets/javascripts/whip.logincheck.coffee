###
  Checks If User Email Sign Was Correct
  If Not, Displays Modal
###
class Whip.LoginCheck
  constructor: (@el) ->

  render: ->
    @el.modal('show');

$(document).on "page:change", ->
  if $('#json_data_bills_index').data('failed')
    loginModal = new Whip.LoginCheck $("#emailsignUpModal")
    loginModal.render()
