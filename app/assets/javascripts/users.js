/*
	Sets user to party and highlights div when clicked
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="users"][data-action="edit"]').length > 0){

	  $('body').off('click','.add_user_to_party_link');
		$('body').on('click','.add_user_to_party_link', function(e){
		  e.preventDefault();
		  var _this = $(this).text();
		  $('#party_name').val(_this);
		  $('#add_party').trigger("submit.rails");
		});
	  
	}
});


/*
	Have to do with uploading user image; LOOK INTO THESE MORE
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="users"][data-action="edit"]').length > 0){

	  $('body').on('click','.change_image_btn', function(e){
		  e.preventDefault();
		});

		$('body').on('change','#user_picture_url',function(e){
		  e.preventDefault();
		});
	  
	}
});

/*
	Helps set user's post code
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="users"][data-action="edit"]').length > 0){

	  function testPostCode () {
		  var newPostCode = checkPostCode  (document.getElementById('postcode').value);
		  if (newPostCode) {
		    document.getElementById('postcode').value = newPostCode;
		    $('#add_postcode').trigger("submit.rails");
		  }  else {
		  	// alert ("Postcode has invalid format");
		  	$('#warningModal .modal-body').html('<p>Postcode has invalid format</p>');
		  	$('#warningModal').modal('show');
		  	}
		}
		$('body').off('click','#postcode_check');
		$('body').on('click','#postcode_check', function(e){
		  e.preventDefault();
		  testPostCode();
		});
	  
	}
});

/*
	Shows MP div, if MP exists
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="users"][data-action="edit"]').length > 0){

  	var mp = $('#json_data_users_edit').data('mp');
  	if (mp) {
  		$('#meet_div').css('display','block');
  	}

	}
});


/*
	Highlights Party div, if Party exists
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="users"][data-action="edit"]').length > 0){
  	var user = $('#json_data').data('user');

  	if (user && user.party_id) {
  		$('.add_user_to_party_link#' + user.party_id).css({color: '#ef4747', border: '1px solid #333', padding: '10px 14px 7px'});
  	}
  	
	}
});