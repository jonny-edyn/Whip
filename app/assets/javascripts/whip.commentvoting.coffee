###
  Sets up comment btn for user's votes
###
class Whip.CommentBtn
  constructor: (@el) ->

  render: ->
    @el.on 'focus', (e) ->
      _this = $(this)
      _this.siblings('.hidden-comment-btn').css 'display', 'inline'
      _this.siblings('.hidden-comment-btn').fadeIn()
    @el.on 'focusout', (e) ->
      _this = $(this)
      _this.siblings('.hidden-comment-btn').fadeOut()
      _this.siblings('.hidden-comment-btn').css 'display', 'inline'

$(document).on "page:change", ->
  return unless $("body.votes.my_votes").length > 0
  commentBtn = new Whip.CommentBtn $(".comment_field")
  commentBtn.render()