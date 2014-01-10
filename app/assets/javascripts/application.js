//= require underscore-min
//= require backbone-min
//= require_self

_.templateSettings = {
  interpolate: /\{\{\=(.+?)\}\}/g,
  evaluate: /\{\{(.+?)\}\}/g
};

var App ={
  config: {
    language: 'english'
  }
}

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
    App.config.language = language;
    if (language == 'chinese') {
      chinese = true;
      setHeader({ chinese: true });
    } else {
      chinese = false;
      setHeader({ chinese: false });
    }
  })

  $('select').on('change', function (e){
    var language = $(this).val();
    $.ajax({
      method: 'post',
      url: '/api/session/language',
      type: 'json',
      data: {
        language: language
      },
      complete: function () { console.log('session updated', language)},
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    })

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

  function handleNewUserFormSubmit(e) {
    e.preventDefault();
    $('.errors').hide();
    $('.ajaxLoader').show();


    if ($('input[name="username"]').val() == '') {
      $('.ajaxLoader').hide();
      $('#wcgUsernameErrors').text('username must not be blank').show();
      return false
    }

    if ($('input[name="verification_code"]').val() == '') {
      $('.ajaxLoader').hide();
      $('#wcgVerificationCodeErrors').text('verification code must not be blank').show();
      return false
    }

    function onNewUserError (response) {
      ga('send', 'event', 'registration', 'failure');
      $('.ajaxLoader').hide();

      if (response.error && response.error == 'service unavailable') {
        alert(errors[App.config.language].wcg_unavailable);
      }
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
        $('#wcgVerificationCodeErrors').text(errors[App.config.language].verification_code).show();
      } else {
        $('#wcgVerificationCodeErrors').hide();
      }
    }
    function onNewUserCreated (response) {
      ga('send', 'event', 'registration', 'success');
      $('.ajaxLoader').hide();
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
      $('.ajaxLoader').hide();
      $('#rippleAddressErrors').text(errors[App.config.language].public_address).show();
    }
  }

  //$('#newUserForm').live('submit', handleNewUserFormSubmit);



  setCurrentNavLink();
});
