// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.rest
//= require jquery.galleriffic
//= require jquery.history
//= require jush
//= require jquery.opacityrollover
//= require fullcalendar
//= require calendar
//= require_self
//= require rails
//= require dataTables/jquery.dataTables
//= require bookings
//= require jquery.Jcrop.min
// require_tree .





$(document).ready(function() {
	$('div.demo-show:eq(0)> div').hide();  
	  $('div.demo-show:eq(0)> unfold').click(function() {
		$(this).hide();
	    $(this).next().slideToggle('fast');
	  });
    $('.comment_reply').hide();
    $('.comment_reply').before('<a href="#" class="comment_reply_link">svar</a>');

    $('.comment_reply_link').bind('click', function(e) {
        $(this).hide();
        $(this).next().slideDown();
        return false;
    });

  $('input.search_input').each(function(){
    var default_value = $(this).val();
    $(this).focus(function(){
      if ($(this).val() == default_value) $(this).val("");
    });
    $(this).blur(function(){
      if ($(this).val() == "") $(this).val(default_value);
    });
  });

  $('form.upload').bind('submit', function() {
    $('form.upload .spinner').show();
    return true;
  });

  $("#booking_created_at").datepicker({
    dateFormat:'dd.mm.yy',
    firstDay: 1,
    onchange: function(formatted, dates) {
      $('#booking_created_at').DatePickerHide();
    }
  });
  $('#booking_created_at').bind('change', function() {
    var meeting_room_id = $('#booking_meetingroom_id').val();
    var date = $('#booking_created_at').val();
    //$.ajax({
    //  url: "/meetingrooms/"+meeting_room_id+"/bookings?date="+date,
    //  context: document.body,
    //  success: function(data) {
    //    $('.bookings-calendar').replaceWith(data);
    //  }
    //});
    calendarGotoDate(date);
    
    return true;
  });
  $('#password').value = '';
});





/*
var uploadify_file_field;
var uploadify_form;
var filesSelected = false;    
function uploadify_form(form_selector) {
  uploadify_form = $(form_selector);
  uploadify_file_field = $(form_selector + " input:file");

  function onProgress(name, queueID, fileObj, data) { 
    if (data['percentage'] == 100) {
      $("#" + uploadify_file_field[0].id + queueID).html('Behandler fil...'); 
    } else {
      $("#" + uploadify_file_field[0].id + queueID + " .percentage").html('- ' + data['percentage'] + '%'); 
    }
    return false; 
  };

  function onComplete(event, queueID, fileObj, response, data) { 
    eval(response); 
    return false
  };

  uploadify_file_field.uploadify({
    'uploader'     : '/javascripts/uploadify/uploadify.swf',
    'script'       : uploadify_form.attr('action'),
    'cancelImg'    : '/images/cancel.png',
    'fileDataName' : uploadify_file_field[0].name,
    'wmode'        : 'transparent',
    'auto'         : false,
    'onSelect'     : function(event, queueID, fileObj) { filesSelected = true },
    'onProgress'   : onProgress,
    'onComplete'   : onComplete,
    'scriptData'   : {
      '_method'    : uploadify_form.attr('method'), 
      '_http_accept': 'application/javascript'
    },
    });

  uploadify_form.submit(function(e){
    if (filesSelected) {
      // Prevent the normal submit
      e.preventDefault();

      // Collect the parameters and update scriptData
      var params = {};
      $(form_selector + " input").each(function() {
        params[$(this).attr('name')] = encodeURIComponent($(this).attr('value'));
      });
      // Add the session key as well
      params[session_key_name] = encodeURIComponent(session_key);
      uploadify_file_field.uploadifySettings("scriptData", params);
      
      // And action
      uploadify_file_field.uploadifyUpload();
    }
  });

};
*/

