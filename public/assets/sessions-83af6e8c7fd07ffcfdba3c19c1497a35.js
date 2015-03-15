(function() {
  jQuery(function() {
    $("#forgot_password").click(function() {
      return document.getElementById('overlay3').toggle();
    });
    $("#one").click(function(e) {
      $("#baluga")[0].selected = 0;
    });
    return $("#two").click(function(e) {
      $("#baluga")[0].selected = 1;
    });
  });

}).call(this);
