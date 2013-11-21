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

$ = jQuery;

$(function () {
  $('#newUserForm').on('submit', function (e) {
    e.preventDefault();
    function onNewUserError (response) {
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
        $('#wcgVerificationCodeErrors').text('WCG verification code ' + response.error.verification_code[0]).show();
      } else {
        $('#wcgVerificationCodeErrors').hide();
      }
    }
    function onNewUserCreated (response) {
      console.log('user created');
      document.location.href='/my-stats';
    }
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
  });

  $('#signInForm').on('submit', function (e) {
    e.preventDefault();
    function onError (response) {
      $('#loginErrors').show();
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