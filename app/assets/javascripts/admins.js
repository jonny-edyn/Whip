/*
	Sets multiselect for page and adds class to forms and show/hide various parts of page
	$('#body-full[data-controller="some"][data-action="some"]').length > 0
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="admins"][data-action="bills"]').length > 0){
	  
  	  $('.issue_select').multiselect();

		  $('form.edit_bill').addClass('bill_form');
		  $('form.new_bill').addClass('bill_form');

		  $(document).off('click','.show_add');
			$(document).on('click','.show_add',function(e){
				e.preventDefault();
				$('.show_add').fadeOut();
				$('.add_form').fadeIn();
			});

			$(document).off('click','.show_edit');
			$(document).on('click','.show_edit',function(e){
				e.preventDefault();

				var id = $(this).attr('id');
				var fin = 'bill_' + id + '_edit'

				if ( $('#' + fin).is(':visible') ) {
					$('#' + fin).fadeOut();
				} else {
					$('.issues_form').css('display','none');
					$('.edit_form').css('display','none');
					$('#' + fin).fadeIn();
				}
			});

			$(document).off('click','.show_issues');
			$(document).on('click','.show_issues',function(e){
				e.preventDefault();

				var id = $(this).attr('id');
				var fin = 'bill_' + id + '_issues'

				if ( $('#' + fin).is(':visible') ) {
					$('#' + fin).fadeOut();
				} else {
					$('.edit_form').css('display','none');
					$('.issues_form').css('display','none');
					$('#' + fin).fadeIn();
				}
			});

			$(document).off('click','.show_media_links');
			$(document).on('click','.show_media_links',function(e){
				e.preventDefault();

				var id = $(this).attr('id');
				var fin = 'bill_' + id + '_media_links'

				if ( $('#' + fin).is(':visible') ) {
					$('#' + fin).fadeOut();
				} else {
					$('.edit_form').css('display','none');
					$('.issues_form').css('display','none');
					$('#' + fin).fadeIn();
				}
			});

	}
});


/*
	Shows edit form on click
	$('#body-full[data-controller="some"][data-action="some"]').length > 0
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="admins"][data-action="issues"]').length > 0){
	  
  	  $('body').off('click','.show_edit');
			$('body').on('click','.show_edit',function(e){
				e.preventDefault();

				var id = $(this).attr('id');
				var fin = 'issue_' + id

				$('.edit_form').css('display','none');
				$('#' + fin).fadeIn();
			});

	}
});


/*
	Shows edit form on click
	$('#body-full[data-controller="some"][data-action="some"]').length > 0
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="admins"][data-action="parties"]').length > 0){
	  
  	  $('body').off('click','.show_edit');
			$('body').on('click','.show_edit',function(e){
				e.preventDefault();

				var id = $(this).attr('id');
				var fin = 'party_' + id

				$('.edit_form').css('display','none');
				$('#' + fin).fadeIn();
			});

	}
});
