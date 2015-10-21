/*
	Shows the Accept Terms modal, if user hasn't already accepted
	$('#body-full[data-controller="some"][data-action="some"]').length > 0
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  var user = $('#json_data').data('user');
  if (user && !user.accepted_terms){
		$('#acceptTermsModal').modal({
				    backdrop: 'static',
				    keyboard: false
				});
		$('#acceptTermsModal').modal('show');
	};
});


/*
	Center Modal Function
*/
function centerModal() {
	$(this).css('display', 'block');
	var $dialog = $(this).find(".modal-dialog");
	var offset = ($(window).height() - $dialog.height()) / 2;
	//Make sure you don't hide the top part of the modal w/ a negative margin if it's longer than the screen height, and keep the margin equal to the bottom margin of the modal
	var bottomMargin = $dialog.css('marginBottom');
	bottomMargin = parseInt(bottomMargin);
	if(offset < bottomMargin) offset = bottomMargin;
	$dialog.css("margin-top", offset);
}

$('.modal').on('show.bs.modal', centerModal);
$(window).on("resize", function () {
	$('.modal:visible').each(centerModal);
});


/*
	Sets active class for best matching pathname
*/
$(document).on('ready page:load', function(event) {
  var pathname = $(location).prop('pathname').split('/')[1]; 
  var best_distance = 999; 
  var best_match = false;
    
  $('#top-navbar ul.nav a').each(function() {
      if ($(this).attr('href').indexOf(pathname) >= 0) {
      	overlap_penalty = pathname.replace($(this).attr('href'), '').length;
          if (overlap_penalty < best_distance) { 
              best_distance = overlap_penalty; 
              best_match = this; 
          }
      }
      
  });

  if (best_match !== false) {
  	$(best_match).closest('.nav-parent-item').addClass('active');
  }
});


/*
	Show tooltip
*/
$('[data-toggle="tooltip"]').tooltip();


/*
	Sets active class for admin nav
*/
$(document).on('ready page:load', function(event) {
  $('#admin-sidebar ul.nav a').filter(function() {
		return this.href == window.location;
	}).parent().addClass('active');
});


/*
	Pops up modals, if MP doesn't have various accounts
*/
$(document).on('ready page:load', function(event) {
  
	$('body').off('click','#no_fb_modal');
  $('body').on('click', '#no_fb_modal', function(e){
    e.preventDefault();

    $('#noFBModal').modal('show');

  });

  $('body').off('click','#no_tw_modal');
  $('body').on('click', '#no_tw_modal', function(e){
    e.preventDefault();

    $('#noTWModal').modal('show');

  });

  $('body').off('click','#mp_email_modal');
  $('body').on('click', '#mp_email_modal', function(e){
    e.preventDefault();

    $('#mpEmailModal').modal('show');

  });
  
});



