// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require gmaps/google
//= require underscore-min
//= require_tree .
function deactivateAlert(elem){
  var elemID = jQuery(elem).attr("id");
  if(elemID == -1){
    closeAlert(elem);
  }
  else{
    $.ajax({
      url: '/deactivate',
      data:{
        id: elemID
      },
      method: 'post',
      success: function(data){
    	  closeAlert(elem);
      },
      failure: function(data){
        alert("Something went wrong !!!");
      }
    });
  }
}//= require websocket_rails/main
