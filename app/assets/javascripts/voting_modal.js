/*
	Shows sign up modal, if previous sign up attempt failed
	$('#body-full[data-controller="some"][data-action="some"]').length > 0
*/

$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  var right_page = function(){
		return $('#body-full[data-controller="bills"][data-action="index"]').length > 0 ||
		$('#body-full[data-controller="bills"][data-action="show"]').length > 0 ||
		$('#body-full[data-controller="issues"][data-action="find_issues"]').length > 0 ||
		$('#body-full[data-controller="users"][data-action="show"]').length > 0 ||
		$('#body-full[data-controller="votes"][data-action="my_votes"]').length > 0
	}

  if (right_page){
  	  
  	$('body').off('click','.bill_voting');
		$('body').on('click','.bill_voting', function(e){
			e.preventDefault();

			var this_form = $(this);
			var comment_section = $(this_form).children('.hidden_comment');
			var find_bill = $(this_form).find("#bill_id").val();


			if ( this_form.hasClass('vote_yes') ) {
				//$('#commentModal').addClass('modal-whip-vote-yes');
				$('#myModalLabelVote').html('<span class="text-vote-yes">VOTED FOR</span>');
				$('.vote_comment_placeholder').attr("placeholder", "YOUR COMMENT - WHY SHOULD OTHERS VOTE FOR?");
			} else {
				//$('#commentModal').addClass('modal-whip-vote-no');
				$('#myModalLabelVote').html('<span class="text-vote-no">VOTED AGAINST</span>');
				$('.vote_comment_placeholder').attr("placeholder", "YOUR COMMENT - WHY SHOULD OTHERS VOTE AGAINST?");
			}

			$('.find_bill_id').text(find_bill);

			comment_section.val('testing');
			
			$('#commentModal').modal('show');

			$('#commentModal').on('hide.bs.modal', function(e){
				var comment_modal = $(this);
				var new_comment = $(comment_modal).find('#content').val();
				comment_section.val(new_comment);
				
				ga('send', 'event', 'Users', 'Voted');
				this_form.trigger("submit.rails");
			});

			// Need to rework this still
			// so far creates modal when vote btn is clicked
			// and submits vote on closing of modal
			// need to add right facing triangle action btn to 'submit' vote
			// this will actually just hide comment box and text at top of modal
			// actual submission happens on close of modal
			// also need to have social share icons slide up / center in modal after other stuff is hidden

			
			$('#commentModal').off('click','#add_comment');
			$('#commentModal').on('click','#add_comment',function(e){
				var new_comment = $(this).siblings('#content').val();
				comment_section.val(new_comment);
				$('#vote-modal-comment').hide();
				$('#vote-modal-social').fadeIn();
				//$('#commentModal').modal('hide');
				//this_form.trigger("submit.rails");
			});

		});
	}
});