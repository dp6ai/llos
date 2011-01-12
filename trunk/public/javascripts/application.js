jQuery(document).ready(function(){
    // only care about ranges for now
    if (jQuery("li[id="+LLOS.current_range+"]").length > 0) {
      jQuery('ul[id=ranges]').scrollTo('li[id='+LLOS.current_range+']', 500, { easing:'swing' });
    }

    if (jQuery("#errorExplanation").length > 0) {
        jQuery("#trigger_dialog").fancybox({
	            'scrolling'		: 'no',
	            'titleShow'		: false
        });

        jQuery("#trigger_dialog").trigger('click');
    }

});
