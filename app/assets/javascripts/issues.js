/*
	Sets up masonry for common bills
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="issues"][data-action="find_issues"]').length > 0){

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
  if ($('#body-full[data-controller="issues"][data-action="find_issues"]').length > 0){

	  $('.trending_bills').slick({
	    accessibility: true,
	    adaptiveHeight: true,

	  });
	  
	}
});