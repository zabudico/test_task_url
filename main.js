$(document).ready(function() {
  // Register form submission
  $('#register-form').submit(function(event) {
    event.preventDefault();
    var name = $('#register-name').val();
    var login = $('#register-login').val();
    var password = $('#register-password').val();

    $.ajax({
      url: 'auth.php',
      type: 'POST',
      data: {
        action: 'register',
        name: name,
        login: login,
        password: password
      },
      dataType: 'json',
      success: function(response) {
        if (response.success) {
          alert(response.message);
        } else {
          alert(response.message);
        }
      }
    });
  });

  // Login form submission
  $('#login-form').submit(function(event) {
    event.preventDefault();
    var login = $('#login-login').val();
    var password = $('#login-password').val();

    $.ajax({
      url: 'auth.php',
      type: 'POST',
      data: {
        action: 'login',
        login: login,
        password: password
      },
      dataType: 'json',
      success: function(response) {
        if (response.success) {
          alert(response.message);
        } else {
          alert(response.message);
        }
      }
    });
  });

  // Create URL form submission
  $('#create-url-form').submit(function(event) {
    event.preventDefault();
    var url = $('#url-input').val();

    $.ajax({
      url: 'urls.php',
      type: 'POST',
      data: {
        url: url
      },
      dataType: 'json',
      success: function(response) {
        if (response.success) {
          var shortUrl = response.short_url;
          var listItem = '<li><a href="' + shortUrl + '" target="_blank">' + shortUrl + '</a></li>';
          $('#urls').append(listItem);
        } else {
          alert(response.message);
        }
      }
    });
  });

  // Load URLs on page load
  $.ajax({
    url: 'get_urls.php',
    type: 'GET',
    dataType: 'json',
    success: function(response) {
      if (response.success) {
        var urls = response.urls;
        for (var i = 0; i < urls.length; i++) {
          var shortUrl = urls[i].short_url;
          var listItem = '<li><a href="' + shortUrl + '" target="_blank">' + shortUrl + '</a></li>';
          $('#urls').append(listItem);
        }
      } else {
        alert(response.message);
      }
    }
  });
});
