/*
  HOLD JS FOR TIME BEING UNTIL DESIGN CHANGES IMPLEMENTED
*/

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
  Voting Modal
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

/*
  Sets multiselect for page and adds class to forms and show/hide various parts of page
  $('#body-full[data-controller="some"][data-action="some"]').length > 0
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="admins"][data-action="bills"]').length > 0){
    
      

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
        console.log(fin);

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