jQuery(document).ready(function() 
{
	// Build tabs...
	jQuery('#tabs > ul').tabs({ fx: { height: 'toggle', opacity: 'toggle' } });
	
	// Animate the hiding of any flash elements...
  jQuery("div.flash").show("drop", { direction: "up"}, 1000);
	setTimeout( function(){jQuery("div.flash").hide("scale", {}, 1000);}, 5000);
});
