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

var pageLanguage = 'english';

var errors = {
  english: {
    wcg_unavailable: "The WCG Service is currently unavailable. Please try again later",
    verification_code: 'The WCG username or verification code you entered is incorrect',
    not_registered: 'You are not registered with computingforgood.org yet. Please sign up',
    public_address: 'Please enter a valid Ripple public address'
  },
  chinese: {
    wcg_unavailable: "WCG正在更新统计信息, 请等待一段时间再试一次.",
    verification_code: ' 你的WCG 用户名或WCG 验证码不对',
    not_registered: '你没有注册，请在此处注册。',
    public_address: '这不是一个有效的 Ripple 钱包地址。'
  }
};

$ = jQuery;

$(function () {

  window.setCurrentNavLink = function () {
    var matches = [];
    _.each($('a'), function (a) {
      $('li').removeClass('current_page_item');
      if ($(a).attr('href') == document.location.pathname) {
        matches.push(a);
      }
    });

    console.log(matches);
    _.each(matches, function(a) {
      $(a).closest('li').addClass('current_page_item');
    })
  }

  window.setHeader = function (opts) {
    if (opts.chinese) {
      $('header').html(_.template($('#headerTemplateChinese').html()),{});
    } else {
      $('header').html(_.template($('#headerTemplate').html()),{});
    }
    setCurrentNavLink();
  }

  $(document).on('change:language', function(event, language) {
    pageLanguage = language;
    if (language == 'chinese') {
      chinese = true;
      setHeader({ chinese: true });
    } else {
      chinese = false;
      setHeader({ chinese: false });
    }
  })

  $('select').on('change', function (e){
    if ($(this).val() == 'chinese') {
      $(document).trigger('change:language', 'chinese');
    } else {
      $(document).trigger('change:language', 'english');
    }
  })
  var chinese;

  if (chinese) {
    $('header').html(_.template($('#headerTemplateChinese').html()),{});
  } else {
    $('header').html(_.template($('#headerTemplate').html()),{});
  }

  $('#newUserForm').live('submit', function (e) {
    e.preventDefault();
    function onNewUserError (response) {
      $('.ajaxLoader').hide();

      if (response.error && response.error == 'service unavailable') {
        alert(errors[pageLanguage].wcg_unavailable);
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
        $('#wcgVerificationCodeErrors').text(errors[pageLanguage].verification_code).show();
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
      $('#rippleAddressErrors').text(errors[pageLanguage].public_address).show();
    }
  });

  $('#signInForm').live('submit', function (e) {
    e.preventDefault();
    function onError (response) {
      $('.ajaxLoader').hide();

      if (response.error == 'no registration') {
        $('#loginErrors').html(errors[pageLanguage].not_registered);
        $('#loginErrors').append($('<a/>').text('here.').attr('href', '/register')).show();
      } else {
        $('#loginErrors').show();
      }
    }
    function onSuccess (response) {
      $('.ajaxLoader').hide();
      document.location.href='/my-stats';
    }
    $('.ajaxLoader').show();
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

  setCurrentNavLink();
});