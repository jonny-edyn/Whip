###
  Sets User Settings For Edit Page
###
class Whip.UserSetting
  constructor: (@el) ->
    @user = $('#json_data').data('user')

  setNewParty: (clickEl) ->
    text = $(clickEl).text()
    $('#party_name').val(text)
    $('#add_party').trigger("submit.rails")

  renderPartyBox: ->
    if @user && @user.party_id
      $(@el + "#" + @user.party_id).css({color: '#ef4747', border: '1px solid #333', padding: '10px 14px 7px'})

$(document).on "page:change", ->
  partyBox = new Whip.UserSetting ".add_user_to_party_link"
  partyBox.renderPartyBox()
  
  $(document).on 'click','.add_user_to_party_link', (e) ->
    e.preventDefault()
    partyBox.setNewParty(this)


Whip.testPostCode = ->
  newPostCode = checkPostCode(document.getElementById('postcode').value)
  if newPostCode
    document.getElementById('postcode').value = newPostCode
    $('#add_postcode').trigger 'submit.rails'
  else
    $('#warningModal .modal-body').html '<p>Postcode has invalid format</p>'
    $('#warningModal').modal 'show'

$(document).on 'click','#postcode_check', (e) ->
  e.preventDefault()
  Whip.testPostCode()