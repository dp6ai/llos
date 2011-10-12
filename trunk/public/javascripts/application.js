var current_controller;
var init_lat;
var init_long;

var geocoder = new google.maps.Geocoder();
var distance_service = new google.maps.DistanceMatrixService();


jQuery(document).ready(function() {
    // only care about ranges for now
    if (jQuery("li[id=" + LLOS.current_range + "]").length > 0) {
        jQuery('ul[id=ranges]').scrollTo('li[id=' + LLOS.current_range + ']', 500, { easing:'swing' });
    }

    if (jQuery("#errorExplanation").length > 0) {
        jQuery("#trigger_dialog").fancybox({
            'scrolling'        : 'no',
            'titleShow'        : false
        });

        jQuery("#trigger_dialog").trigger('click');
    }


    jQuery('.slideshow').cycle({
		fx: 'fade'
	});
    
    if (current_controller == "stockists") {

        if (current_view == "msp") {
	    	sniffLocation();
		}

        jQuery('#stockist_form').submit(function() {
            var address = jQuery("input:first").val();
            console.log('Handler for .submit() called : ' + address);

            // Geocode whatever we have for the users address
            var myOptions = {
                zoom: 9,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            var map;
            var infowindows = [];
            var origin;

            // clear out results
            jQuery(".stockist_result").hide();
            jQuery("#results p#title").hide();
            jQuery(".stockist_result p").text("");
            jQuery(".stockist_result a").hide();
            jQuery("#results p#message").hide();
            jQuery("#results p#enquiries").hide();

			//if (current_view != "msp") {
			//	jQuery(".stockist_map").hide();
			//}

            console.log("address : " + address);

            if (address != '') {
                geocoder.geocode({'address': address}, function(results, status) {

                    if (status == google.maps.GeocoderStatus.OK) {
                        map = new google.maps.Map(jQuery("#results_canvas")[0], myOptions);
                        origin = results[0].geometry.location
                        console.log("OK : " + origin);

                        jQuery.getJSON('/stockist_search', { latitude: origin.lat(), longitude: origin.lng() }, function(results) {

                            jQuery("#results p#title").show();

                            jQuery.each(results, function(index, val) {

                                jQuery(".stockist_name:eq(" + index + ")").text(val.stockist.name);
                                jQuery(".stockist_address_line_one:eq(" + index + ")").text(val.stockist.address_line_one);
                                jQuery(".stockist_address_line_two:eq(" + index + ")").text(val.stockist.address_line_two);
                                jQuery(".stockist_town:eq(" + index + ")").text(val.stockist.town);
                                jQuery(".stockist_city:eq(" + index + ")").text(val.stockist.city);
                                jQuery(".stockist_postcode:eq(" + index + ")").text(val.stockist.postcode);
                                jQuery(".stockist_url:eq(" + index + ")").text(val.stockist.url);
                                jQuery(".stockist_url:eq(" + index + ")").attr("href",val.stockist.url);
                                jQuery(".stockist_result a:eq(" + index + ")").show();

                                var marker = new google.maps.Marker({
                                    position: new google.maps.LatLng(val.stockist.latitude, val.stockist.longitude),
                                    title: val.stockist.name + ", " + val.stockist.address_line_one + " " + val.stockist.postcode,
                                    map: map
                                });

                                jQuery(".stockist_map:eq(" + index + ")").click(function() {
                                    console.log("View on MAP :"+val.stockist.name);

                                    var infowindow = new google.maps.InfoWindow({
                                        content: val.stockist.name +", "+val.stockist.postcode
                                    });

                                    jQuery.each(infowindows, function(index, val) {
                                        infowindows[index].close();
                                    });

                                    map.panTo(new google.maps.LatLng(val.stockist.latitude, val.stockist.longitude));
                                    infowindows.push(infowindow);
                                    infowindow.open(map, marker);
                                });

                            });

                            if (results.length == 0) {
                                jQuery("#results p#message").show();
                                jQuery("#results p#title").hide();
                            } else {
                                jQuery("#results p#title").show();
                                jQuery("#results p#enquiries").show();
                                jQuery(".stockist_result").show("slow");
                                jQuery(".stockist_url").show();
                                if (current_view != 'msp'){
                                    jQuery(".stockist_map").hide();
                                }
                            }
                        });

                        map.setCenter(origin);

                        marker = new google.maps.Marker({
                            position: origin,
                            title: "your current location " + address,
                            map: map
                        });

                    } else {
                        alert("We were unable to geolocate your position from the address provided, please try again: " + status);
                    }
                });
            } else {
                alert("Please enter a location into the search field");
                jQuery("#address").focus();
            }


            return false;
        });
    }
});

// END DOC READY


// classes
function Stockist(id, name, add1, add2, town, city, postcode, latitude, longitude) {
    this.id = id;
    this.name = name;
    this.address_line_one = add1;
    this.address_line_two = add2;
    this.town = town;
    this.city = city;
    this.postcode = postcode;
    this.latitude = latitude;
    this.longitude = longitude;
    this.latlng = new google.maps.LatLng(latitude, longitude);
    this.distance;
    this.distance_raw;
    this.duration;
    this.duration_raw;
    this.toString = function() {
        return "id: " + this.id + " name: " + this.name + " latlng: " + this.latlng.toUrlValue(2) + " distance: " + this.distance + " (" + this.distance_raw + " meters) duration: " + this.duration + " (" + this.duration_raw + " secs)";
    }
}

function collectStockists() {

    var stockist;

    jQuery(".stockist").each(function(index) {

        console.log(jQuery(this));

        stockist = new Stockist(jQuery(this).children("dl").find(".id").text()
            , jQuery(this).children("dl").find(".name").text()
            , jQuery(this).children("dl").find(".address_line_one").text()
            , jQuery(this).children("dl").find(".address_line_two").text()
            , jQuery(this).children("dl").find(".town").text()
            , jQuery(this).children("dl").find(".city").text()
            , jQuery(this).children("dl").find(".postcode").text()
            , jQuery(this).children("dl").find(".lat").text()
            , jQuery(this).children("dl").find(".long").text());


        console.log("loaded stockist: " + stockist.toString());
        stockists.stockists.push(stockist);
        stockists.stockist_destinations.push(stockist.latlng);
        // careful of the precision, we need a key to tie the stockists back together after a distance search
        stockists.stockist[stockist.latlng.toUrlValue(2)] = stockist;

    });

}

function sniffLocation() {
    // Try W3C Geolocation (Preferred)
    if (navigator.geolocation) {
        browserSupportFlag = true;
        navigator.geolocation.getCurrentPosition(function(position) {
            init_lat = position.coords.latitude;
            init_long = position.coords.longitude;
            setDefaultPosition("W3C", init_lat, init_long);

        }, function() {
            handleNoGeolocation(browserSupportFlag);
        });
        // Try Google Gears Geolocation
    } else if (google.gears) {
        browserSupportFlag = true;
        var geo = google.gears.factory.create('beta.geolocation');
        geo.getCurrentPosition(function(position) {
            init_lat = position.coords.latitude;
            init_long = position.coords.longitude;
            setDefaultPosition("Gears", init_lat, init_long);
        }, function() {
            handleNoGeoLocation(browserSupportFlag);
        });
        // Browser doesn't support Geolocation
    } else {
        browserSupportFlag = false;
        handleNoGeolocation(browserSupportFlag);
    }
}

function handleNoGeolocation(errorFlag) {
    if (errorFlag == true) {
        alert("Unable to automatically calculate your location, please enter you address in the field provided");
        init_lat = 0;
        init_long = 0;
    } else {
        alert("Your browser doesn't support geolocation..");
        init_lat = 0;
        init_long = 0;
    }

    setDefaultPosition("No GEO", init_lat, init_long);
}

function setDefaultPosition(service, init_lat, init_long) {
    console.log(service + " init_lat: " + init_lat + " init_long: " + init_long);
    if (init_lat != 0) {
        geocoder.geocode({'address': init_lat + ", " + init_long}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                jQuery('#address').val(results[0].formatted_address);
            }
        })
    }
}