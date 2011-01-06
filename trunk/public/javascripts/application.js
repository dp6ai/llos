// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(document).ready(function(){
  // only care about ranges for now
  if (jQuery("li[id="+LLOS.current_range+"]").length > 0) {
    jQuery('ul[id=ranges]').scrollTo('li[id='+LLOS.current_range+']', 500, { easing:'swing' });
  }
});
