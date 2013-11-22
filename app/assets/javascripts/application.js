// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .
//= require_self

_.templateSettings = {
  interpolate: /\{\{\=(.+?)\}\}/g,
  evaluate: /\{\{(.+?)\}\}/g
};



$ = jQuery;

$(function () {
  $('#newUserForm').on('submit', function (e) {
    e.preventDefault();
    function onNewUserError (response) {
      $('.ajaxLoader').hide();

      if (response.error && response.error == 'service unavailable') {
        alert("The WCG Service is currently unavailable. Please try again later");
      }
      console.log(response);
      if (response.error && response.error.member_id && response.error.member_id.length > 0) {
        $('#wcgUsernameErrors').text('username ' + response.error.member_id[0]).show();
      } else {
        $('#wcgUsernameErrors').hide();
      }

      if (response.error && response.error.ripple_address && response.error.ripple_address.length > 0) {
        $('#rippleAddressErrors').text('ripple public address ' + response.error.ripple_address[0]).show();
      } else {
        $('#rippleAddressErrors').hide();
      }

      if (response.error && response.error.verification_code && response.error.verification_code.length > 0) {
        $('#wcgVerificationCodeErrors').text('The WCG username or verification code you entered is incorrect').show();
      } else {
        $('#wcgVerificationCodeErrors').hide();
      }
    }
    function onNewUserCreated (response) {
      $('.ajaxLoader').hide();
      console.log('user created');
      document.location.href='/my-stats';
    }

    var ripple_address = $('input[name="ripple_address"]').val();
    var validRippleAddress = ripple.UInt160.from_json(ripple_address).is_valid();
    if (validRippleAddress) {
      $('#rippleAddressErrors').hide();
      $('.ajaxLoader').show();
      $.ajax({
        method: 'post',
        url: '/api/users',
        type: 'json',
        data: $(this).serialize(),
        success: function (response) {
          if (response.error) {
            onNewUserError(response);
          } else {
            onNewUserCreated(response);
          }
        },
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      })
    } else {
      $('#rippleAddressErrors').text('Please enter a valid Ripple public address').show();
    }
  });

  $('#signInForm').on('submit', function (e) {
    e.preventDefault();
    function onError (response) {
      if (response.error == 'no registration') {
        $('#loginErrors').html('You are not registered with computingforgood.org yet. Please sign up ');
        $('#loginErrors').append($('<a/>').text('here.').attr('href', '/register')).show();
      } else {
        $('#loginErrors').show();
      }
    }
    function onSuccess (response) {
      document.location.href='/my-stats';
    }
    $.ajax({
      method: 'post',
      url: '/api/sessions',
      type: 'json',
      data: $(this).serialize(),
      success: function (response) {
        if (response.error) {
          onError(response);
        } else {
          onSuccess(response);
        }
      },
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    })
  });
});