/*
	Shows sign up modal, if previous sign up attempt failed
	$('#body-full[data-controller="some"][data-action="some"]').length > 0
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="bills"][data-action="index"]').length > 0){
	  var failed = $('#json_data_bills_index').data('failed');
	  console.log(failed);
	  if (failed){
			$('#emailsignUpModal').modal('show');
		};
	}
});


/*
	Sets up masonry for common bills
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="bills"][data-action="index"]').length > 0){

	  $('#hold_common_bills').masonry({
	    // options
	    itemSelector : '.masonary_sizing',
	  });

	  $("#hold_common_bills").infinitescroll({
	    navSelector: "nav.pagination",
	    nextSelector: "nav.pagination a[rel=next]",
	    itemSelector: ".masonary_sizing",
	    debug: true,          
	  }, function( newElements ) {
		    var $newElems = $( newElements );
		    $("#hold_common_bills").masonry( 'appended', $newElems );
	  });

	}
});


/*
	Sets up slick slider for trending bills
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="bills"][data-action="index"]').length > 0){

	  $('.trending_bills').slick({
	    accessibility: true,
	    adaptiveHeight: true,

	  });
	  
	}
});


/*
	Sets background color of divs corresponding to current progress
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="bills"][data-action="show"]').length > 0){

	var current_progess = $('#bill-progress-table').data('bill-progress');
	var finder_name = current_progess + "_div"
	$('.' + finder_name).parent().css('background-color','#DAD7D7');
	  
	}
});
