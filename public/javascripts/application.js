// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
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
});

function updateFleet () {
  var fleet_id = $(".fleet").attr("data-id");
  if ($(".fleet").length > 0) {
    var after = $(".fleet").attr("data-time");
  } else {
    var after = "0";
  }
  
  $.getScript("/fleets/" + fleet_id + ".js?after=" + after);
  setTimeout(updateFleet, 10000);
}

function updateReports () {
  var fleet_id = $(".fleet").attr("data-id");
  if ($(".report").length > 0) {
    var after = $(".report:first-child").attr("data-time");
  } else {
    var after = "0";
  }
  
  $.getScript("/fleets/" + fleet_id + "/reports.js?after=" + after);
  setTimeout(updateReports, 10000);
}

function ping () {
  $.getScript("/ping.js");
  setTimeout(ping, 10000);
}
