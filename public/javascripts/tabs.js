$(document).ready(function() 
{
	// Build tabs...
	$('#tabs > ul').tabs({ fx: { height: 'toggle', opacity: 'toggle' } });
	
	// Animate the hiding of any flash elements...
  $("div.flash").show("drop", { direction: "up"}, 1000);
	setTimeout( function(){$("div.flash").hide("scale", {}, 1000);}, 5000);
});
