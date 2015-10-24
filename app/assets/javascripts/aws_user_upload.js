var awsUserUpload = function(s3_url, s3_fields) {
  $('.user_image_form').find("input:file").each(function(i, elem) {
    var fileInput    = $(elem);
    var form         = $(fileInput.parents('form:first'));
    var submitButton = form.find('input[type="submit"]');
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
       
      },
      start: function (e) {
        submitButton.prop('disabled', true);
        $(submitButton).val('Saving...');
        console.log('this is working');
        
      },
      done: function(e, data) {
        submitButton.prop('disabled', false);

        // extract key and generate URL from response
        var key   = $(data.jqXHR.responseXML).find("Key").text();
        var url   = '//' + s3_url.host + '/' + key;

        // create hidden field
        var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
        form.append(input);
        console.log(data);
        $('.user_image_form').trigger("submit.rails");
      },
      fail: function(e, data) {
        submitButton.prop('disabled', false);

       
      }
    });
  });
};

$(document).on('ready page:load', function(event) {
  // apply non-idempotent transformations to the body
  if ($('#body-full[data-controller="users"][data-action="edit"]').length > 0){
    var awsUpload = window.awsUserUpload;
    var s3_url = $('#json_data_users_edit').data('s3_url');
    var s3_fields = $('#json_data_users_edit').data('s3_fields');
    awsUpload(s3_url, s3_fields)
  }
});