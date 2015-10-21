/*
	Adds Change Comment button on focus and Removes on focusout of comment box
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="votes"][data-action="my_votes"]').length > 0){

	  $('.comment_field').off('focus');
		$('.comment_field').on('focus', function(e){

			var _this = $(this)
			_this.siblings('.hidden-comment-btn').css('display','inline');
			_this.siblings('.hidden-comment-btn').fadeIn();

		});

		$('.comment_field').off('focusout');
		$('.comment_field').on('focusout', function(e){

			var _this = $(this)
			_this.siblings('.hidden-comment-btn').fadeOut();
			_this.siblings('.hidden-comment-btn').css('display','inline');

		});

	}
});
