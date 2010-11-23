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
  if ($("#details").length > 0) {
    setTimeout(updateFleet, 20*1000);
    
    $(".toggle").click(function() {
      $(this).next(".section").slideToggle("fast");
      return false;
    });
  } else if ($("#ping").length > 0) {
    setTimeout(ping, 20*1000);
  }
  
  function updateFleet () {
    var fleet_id = $(".fleet").attr("data-id");
    if ($(".fleet").length > 0) {
      var after = $(".fleet").attr("data-time");
    } else {
      var after = "0";
    }
		
    $.getScript(base_url + "fleets/" + fleet_id + ".js?after=" + after);
    setTimeout(updateFleet, 20000);
  }

  function updateReports () {
    var fleet_id = $(".fleet").attr("data-id");
    if ($(".report").length > 0) {
      var after = $(".report:first-child").attr("data-time");
    } else {
      var after = "0";
    }

    $.getScript(base_url + "fleets/" + fleet_id + "/reports.js?after=" + after);
    setTimeout(updateReports, 20000);
  }

  function ping () {
    $.getScript(base_url + "ping.js");
    setTimeout(ping, 10000);
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
