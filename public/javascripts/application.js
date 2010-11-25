// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
	setTimeout(function() {
	  $('div.flash').fadeTo("slow", 0.01, function() {
	                                      	$(this).slideUp("medium", function() {
	                                          $(this).remove();
	                                        });
	                                      });
		}, 3000); // <-- time in milliseconds
	// setTimeout("$$('div.flash').each(function(flash){ flash.hide();})", 10000);
  //hover states on the static widgets
  $('.pilots .user').live({ mouseenter: function() { $(this).addClass('hover'); }, mouseleave: function() {
  $(this).removeClass('hover'); } });
	$("abbr.timeago").timeago();
});

$(function() {
	if ($("#ping").length > 0) {
		var ping_refresh = $('#ping').attr('data-refresh');
		var ping_base_url = $('#ping').attr('data-base-url');
    setTimeout(ping, ping_refresh);
  }

  if ($("#details").length > 0) {
	  var fleet_refresh = $('.fleet').attr('data-refresh');
		var fleet_base_url = $('.fleet').attr('data-base_url');
    var fleet_id = $(".fleet").attr("data-id");
    var fleet_after = $(".fleet").attr("data-time");
    setTimeout(updateFleet, fleet_refresh);
    
  }

  $(".toggle").click(function() {
    $(this).next(".section").slideToggle("fast");
    return false;
  });
  
  function updateFleet () {
    $.getScript(fleet_base_url + "fleets/" + fleet_id + ".js?after=" + fleet_after);
    setTimeout(updateFleet, fleet_refresh);
  }

  function ping () {
    $.getScript(ping_base_url + "ping.js");
    setTimeout(ping, ping_refresh);
  }

});

$(document).ready(function() {
  $('a.popup').click(function() {
    $('<div />').appendTo('body').dialog({
      title: $(this).attr('title'),
      modal: true
    }).load($(this).attr('href') + ' form', function() {
      $form = $(this).find('form')
      $form.find(':text:first').focus();
      /*$btn = $form.find(':submit');
      var txt = $btn.val();
      $btn.remove();
      var buttons = {};
      buttons[txt] = function() {
        $.ajax({
          type: $form.attr('method'),
          url: $form.attr('action'),
          data: $form.serialize(),
          dataType: 'script',
          complete: function(xhr, status) {
            $form.append('<div class="'+status+'">'+xhr.responseText+'</div>');
            return false;
          }
        });
      };*/
      $(this).dialog('option','buttons'/*, buttons */);
    });
    return false;
  });
});
