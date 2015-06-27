var markers, lat, lng;
$(document).ready(function(){
  $.slidebars({
    siteClose: false
  });
  consumerToggle();
  
$('#help_me_accordion').on('show.bs.collapse', function () {
  $("#show_more_accordion").collapse("hide");
});
$('#show_more_accordion').on('show.bs.collapse', function () {
  $("#help_me_accordion").collapse("hide");
});
navigator.geolocation.getCurrentPosition(function(pos){
    window.lat = pos.coords.latitude;
    window.lng = pos.coords.longitude;
});
});

function displayOnMap(position){
  var marker = handler.addMarker({
    lat: position.coords.latitude,
    lng: position.coords.longitude,
    picture: {
          url: "assets/map-marker.png",
          width:  40,
          height: 66
        },
  });
  handler.map.centerOn(marker);
  handler.map.serviceObject.setZoom(12);
};

function consumerToggle(){
  $.slidebars.toggle("left");
  $('#right_menu_button').fadeToggle();
}

function searchForService(service_id){
  handler.removeMarkers(window.markers);
  window.markers='';
  $("#services_modal").modal("hide");
  $.ajax({
    url: 'home/get_users',
    data:{
      service_id: service_id
    },
    method: 'get',
    success: function(data){
      window.markers=handler.addMarkers(data);
    },
    failure: function(data){
      alert("Something went wrong !!!");
    }
  });
 }

function toggleRightMenu() {
  $.slidebars.toggle("right");
  $('#right_menu_button').fadeToggle();
}

function showMore(user_id) {
  $.slidebars.open("right");
  $.ajax({
    url: 'home/user_data',
    data: {
      user_id: user_id
    },
    method: 'get',
    success: function(data){
      $("#provider_details").html(data);
    },
    failure: function(data){
      alert("Something went wrong !!!");
    }
  });
  $('#show_more_accordion').collapse("show");
}

function openRequestCallbackForm(){
  $('#provider_details').hide(1000);
  $('#request_callback_div').show(1000);
}

function closeRequestCallbackForm(){
  $('#provider_details').show(1000);
  $('#request_callback_div').hide(1000);
}

function openHelpCallbackDiv(){
  $('#help_me_content').hide(1000);
  $('#help_callback_div').show(1000);
}
function closeHelpCallbackDiv(){
  $('#help_me_content').show(1000);
  $('#help_callback_div').hide(1000);
}

function requestCallback() {
  $('#please_wait').show(1000);
  $('#request_callback_div').hide(1000);
  provider_id=$('#provider_id').val();
  service_id=$('#service').val();
  requestor_name=$("#requestor_name").val();
  requestor_phone=$("#requestor_phone").val();
  requestor_message=$("#requestor_message").val();
  $.ajax({
    url: 'home/request_callback',
    data: {
      user_id: provider_id,
      service_id: service_id,
      requestor_name: requestor_name,
      requestor_phone: requestor_phone,
      requestor_message: requestor_message
    },
    method: 'get',
    success: function(data){
      $('#please_wait').hide(1000);
      closeRequestCallbackForm();
    },
    error: function(data){
      $('#please_wait').hide(1000);
      alert("Oops !!! Something is wrong :(");
    }
  });
}
function helpMe() {
  requestor_name=$("#help_requestor_name").val();
  requestor_phone=$("#help_requestor_phone").val();
  requestor_message=$("#help_requestor_message").val();
  if(requestor_name==="" || requestor_phone==="" || requestor_message==="") {
    alert("Oops... You are forgetting something here !!!");
    return false;
  }
  $('#help_please_wait').show(1000);
  $('#help_me_content').hide(1000);
  if (window.requestor_marker) {
    window.lat=window.requestor_marker.getServiceObject().getPosition().lat();
    window.lng=window.requestor_marker.getServiceObject().getPosition().lng();
  }
  else if ((window.lat !==undefined)&&(window.lng!==undefined)) {
  }
  else {
    alert("No magic without your support !!!");
    return false;
  }
  service_id=$('#service').val();
  $('#help_callback_div').html("<a href='#' class='pull-right' onclick='closeHelpCallbackDiv();'>Go Back</a>")
  $.ajax({
    url: 'home/help_me',
    data: {
      lat: lat,
      lng: lng,
      service_id: service_id,
      requestor_name: requestor_name,
      requestor_phone: requestor_phone,
      requestor_message: requestor_message,
    },
    method: 'get',
    success: function(data){
      if(data.length===0){
        $('#help_callback_div').prepend("Sorry. No results found near your location.")
      }
      else {
        data.reverse().forEach(function(provider){
          $('#help_callback_div').prepend("<strong>"+provider["name"]+"</strong><br/>"+provider["mobile"]+"<br/><br/>");
        });
        $('#help_callback_div').prepend("<strong>Hey we have asked these people to help you out. Pls get in touch with them.</strong><br/><br/>")
      }
      $('#help_callback_div').show(1000);
      $('#help_please_wait').hide(1000);
      openHelpCallbackDiv();

    },
    error: function(data){
      $('##help_me_content').show(1000);
      $('#help_please_wait').hide(1000);
      alert("Oops !!! Something is wrong :(");
    }
  });

}
function toggleFullScreen() {
  // if (!document.fullscreenElement &&    // alternative standard method
  //     !document.mozFullScreenElement && !document.webkitFullscreenElement) {  // current working methods
  //   if (document.documentElement.requestFullscreen) {
  //     document.documentElement.requestFullscreen();
  //   } else if (document.documentElement.mozRequestFullScreen) {
  //     document.documentElement.mozRequestFullScreen();
  //   } else if (document.documentElement.webkitRequestFullscreen) {
  //     document.documentElement.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
  //   }
  // } else {
  //   if (document.cancelFullScreen) {
  //     document.cancelFullScreen();
  //   } else if (document.mozCancelFullScreen) {
  //     document.mozCancelFullScreen();
  //   } else if (document.webkitCancelFullScreen) {
  //     document.webkitCancelFullScreen();
  //   }
  // }
}
