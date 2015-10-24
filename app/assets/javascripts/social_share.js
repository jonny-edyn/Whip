/*
	Shows the Accept Terms modal, if user hasn't already accepted
	$('#body-full[data-controller="some"][data-action="some"]').length > 0
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  
	$('body').on('click','#fb_share',function(e){
			e.preventDefault();
			var vote_text = $('#myModalLabelVote').text();
			var needed_bill = $('.find_bill_id').text();
			
			$.ajax({
			    type: "GET",
			    url: "/bills/" + needed_bill,
			    dataType: "json",
			    success: function(data){
			      console.log(data);
			      console.log(data.image_url);
			      if (data.social_image_url) {
			      	var right_image = data.social_image_url
			      } else {
			      	var right_image = data.image_url
			      }

			      FB.ui({
					  method: 'share',
					  href: 'www.whip.org.uk/bills/' + data.id,
						}, function(response){});


			    }
			});

			ga('send', 'event', 'Social', 'FB', 'share');

	});

	$('.tw_share').click(function(event) {
		event.preventDefault();
		ga('send', 'event', 'Social', 'TW', 'share');
		var vote_text = $('#myModalLabelVote').text();
		var needed_bill = $('.find_bill_id').text();
		$.ajax({
		    type: "GET",
		    url: "/bills/" + needed_bill,    
		    dataType: "json",
		    success: function(data){
		      console.log(data);
		      console.log(data.image_url);

		      var width  = 575,
		        height = 400,
		        left   = ($(window).width()  - width)  / 2,
		        top    = ($(window).height() - height) / 2,
		        url    = "http://twitter.com/intent/tweet?text=I just " + vote_text + " " + data.simple_name + " at&url=http://www.whip.org.uk/",
		        opts   = 'status=1' +
		                 ',width='  + width  +
		                 ',height=' + height +
		                 ',top='    + top    +
		                 ',left='   + left;
		    
		    window.open(url, 'twitter', opts);
		 


		  }
		});
	});

}); 