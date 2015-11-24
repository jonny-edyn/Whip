###
  Sets up comment btn for user's votes
###
class Whip.CustomModal
  constructor: (@el) ->

  renderSpecial: ->
    @el.modal
      backdrop: 'static'
      keyboard: false

  render: ->
    @el.modal 'show'

$(document).on "page:change", ->
  noFBModal = new Whip.CustomModal $("#noFBModal")
  noTWModal = new Whip.CustomModal $("#noTWModal")
  mpEmailModal = new Whip.CustomModal $("#mpEmailModal")
  noAcceptedTerms = new Whip.CustomModal $("#acceptTermsModal")

  ###
    Show Correct Modal For Missing MP Info
  ###
  $(document).on 'click', '#no_fb_modal', (e) =>
    noFBModal.render()

  $(document).on 'click', '#no_tw_modal', (e) =>
    noTWModal.render()

  $(document).on 'click', '#mp_email_modal', (e) =>
    mpEmailModal.render()

  ###
    Setup Modal For User That Hasn't Accepted Terms
  ###
  user = $('#json_data').data('user')
  if user and !user.accepted_terms
    noAcceptedTerms.renderSpecial()


###
  Setup Modal Centering On Page
###
Whip.centerModal = (el) =>
  console.log 'working'
  el = $(el)
  el.css 'display', 'block'
  dialog = el.find('.modal-dialog')
  offset = ($(window).height() - dialog.height()) / 2
  #Make sure you don't hide the top part of the modal w/ a negative margin if it's longer than the screen height, and 
  #keep the margin equal to the bottom margin of the modal
  bottomMargin = dialog.css('marginBottom')
  bottomMargin = parseInt(bottomMargin)
  if offset < bottomMargin
    offset = bottomMargin
  dialog.css 'margin-top', offset

$(document).on "page:change", ->
  $('.modal').on 'show.bs.modal', ->
    Whip.centerModal(this)

$(window).on 'resize', ->
  if $('.modal:visible').length > 0
    Whip.centerModal($('.modal:visible'))




  