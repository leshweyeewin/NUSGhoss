// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
var apikey = "nt5s4waVtfzugEGRSuW5Z";
var token = "";
var ivle_userid = "";
var ivle_username = "";

function ivleValidation(buttonId){

  $(function(){
    var myapp = new ivle(apikey);

    //TEST AUTH
    var re = /(.*)\/.*/;
    myapp.auth($('#' + buttonId), window.location.origin + "/users/sign_up");
  });
}

function getProfile(){

  var loginUrl = "ivle.nus.edu.sg/api/login/?apikey=nt5s4waVtfzugEGRSuW5Z";

  var myapp = new ivle(apikey);
  //console.log(previousUrl);
  var regex = new RegExp('token=(.+)');
  token = regex.exec(window.location.href);

  if(!token){
    window.location.href = "/";
    alert("Registration must be through IVLE validation. Click on Register to create an account.");
  }else{
      console.log(token);
      profileUri = "https://ivle.nus.edu.sg/api/Lapi.svc/Profile_View?APIKey=" + apikey + "&AuthToken=" + token[1];

      $.ajax({
      url : profileUri,
      dataType:"jsonp",
      success:function(data)
      {
        console.log(JSON.stringify(data));
        ivle_userid = data.Results[0].UserID;
        ivle_username = data.Results[0].Name;
        console.log(ivle_userid);
        console.log(ivle_username);
        $('#user_ivle_id').val(ivle_userid);
        $('#user_ivle_name').val(ivle_username);
        document.getElementById("#user_ivle_id").setAttribute("readonly", "true");
        document.getElementById("#user_ivle_name").setAttribute("readonly", "true");
      },
      error: function(xhr, err, errobj){
        alert("Error in requesting profile data from IVLE");
      }
  });

  }
}


/*
function getJson(){


  var params = {
      "APIKey" : apikey,
      "AuthToken" : token,
      "output" : "json"
  };

  $.ajax({
    type: 'GET',
    dataType: 'jsonp',
    data: params,
    contentType:"application/x-javascript",
    url: profileUri,
    xhrFields: { withCredentials: false },
    success: function(jsonpData){
      var xmlText = new XMLSerializer().serializeToString(xml);
      alert(xmlText);
      //alert(JSON.stringify(jsonpData));
    },
    error: function(xhr, err, errobj){
      console.log('revert to proxy');
      var request = url + "?" +  decodeURIComponent($.param(params));
      //console.log(request);
      if (proxyurl){
        $.ajax({
          type: 'GET',
          dataType: 'json',
          data:{request: request},
          url: proxyurl,
          dataFilter: function(data){
            return $.parseJSON(data);
          },
          success: success,
          error: error
        });
      } else {
        if (error){
          error.apply(this,arguments);
        }
      }
    }
  });
} */
