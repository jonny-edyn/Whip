var awsAdminUpload = function(s3_url, s3_fields) {
  console.log('this is working')
  $('.bill_form').find("#bill_image_url, #bill_social_image_url").each(function(i, elem) {
    var fileInput    = $(elem);
    var form         = $(fileInput.parents('form:first'));
    var submitButton = form.find('input[type="submit"]');
    var progressBar  = $("<div class='bar'></div>");
    var barContainer = $("<div class='progress'></div>").append(progressBar);
    fileInput.after(barContainer);
    fileInput.fileupload({
      fileInput:       fileInput,
      url:             s3_url,
      type:            'POST',
      autoUpload:       true,
      formData:         s3_fields,
      paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
      dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
      replaceFileInput: false,
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        progressBar.css('width', progress + '%')
      },
      start: function (e) {
        submitButton.prop('disabled', true);

        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Loading...");
      },
      done: function(e, data) {
        submitButton.prop('disabled', false);
        progressBar.text("Uploading done");

        // extract key and generate URL from response
        var key   = $(data.jqXHR.responseXML).find("Key").text();
        var url   = '//' + s3_url.host + '/' + key;

        // create hidden field
        var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
        form.append(input);
        console.log(data);
      },
      fail: function(e, data) {
        submitButton.prop('disabled', false);

        progressBar.
          css("background", "red").
          text("Failed");
          console.log(data);
      }
    });
  });
};

/*
  Shows sign up modal, if previous sign up attempt failed
  $('#body-full[data-controller="some"][data-action="some"]').length > 0
*/
$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="admins"][data-action="bills"]').length > 0){
    var awsUpload = window.awsAdminUpload;
    var s3_url = $('#json_data_admins_bills').data('s3_url');
    var s3_fields = $('#json_data_admins_bills').data('s3_fields');
    awsUpload(s3_url, s3_fields)
  }
});