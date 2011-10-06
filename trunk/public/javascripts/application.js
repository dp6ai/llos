//var TOO_FAR_AWAY = 800 * 1000; //KM

var init_lat;
var init_long;

//var stockists = {
//    stockists: [] // array of all
//    ,stockist_destinations: [] // list of latlng for G API
//    ,stockist: {} // hash for search, keyed on latlng
//    ,closest:function() {
//        alert("NYI")
//    }
//};


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


//    collectStockists();
    sniffLocation();

    jQuery('#stockist_form').submit(function() {
        var address = jQuery("input:first").val();
        console.log('Handler for .submit() called : ' + address);

        var geocoder = new google.maps.Geocoder();
        var distance_service = new google.maps.DistanceMatrixService();

        // Geocode whatever we have for the users address
        var myOptions = {
            zoom: 9,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(jQuery("#results_canvas")[0], myOptions);
        var marker;
        var origin;

        // clear out results
        jQuery(".stockist_result").hide();
        jQuery("#results p#title").hide();
        jQuery(".stockist_result p").text("");
        jQuery("#results p#message").hide();
        jQuery("#results p#enquiries").hide();

        geocoder.geocode({'address': address}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {

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


                        marker = new google.maps.Marker({
                            position: new google.maps.LatLng(val.stockist.latitude, val.stockist.longitude),
                            title: val.stockist.name + ", "+val.stockist.address_line_one+" "+val.stockist.postcode,
                            map: map
                        });

                    });

                    if (results.length == 0) {
                        jQuery("#results p#message").show();
                        jQuery("#results p#title").hide();
                    } else {
                        jQuery("#results p#title").show();
                        jQuery("#results p#enquiries").show();
                        jQuery(".stockist_result").show("slow");
//                        jQuery(".#results_canvas").show("slow");
                    }
                });

                map.setCenter(origin);

                marker = new google.maps.Marker({
                    position: origin,
                    title: "your current location " + address,
                    map: map
                });


//                jQuery.each(stockists.stockists, function(index, value) {
//                    console.log("name: " + stockists[index].name + " lat: " + stockists[index].lat + " long: " + stockists[index].longi + " latlong: " + stockists[index].latlong);
//                    stockist_destinations[index] = stockists.stockists[index].latlong;
//                })

//                distance_service.getDistanceMatrix({
//                        origins: [origin],
//                        destinations: stockists.stockist_destinations,
//                        travelMode: google.maps.TravelMode.DRIVING,
//                        avoidHighways: false,
//                        avoidTolls: false }, function (response, status) {
//
//                        if (status == google.maps.DistanceMatrixStatus.OK) {
//                            var origins = response.originAddresses;
//                            var destinations = response.destinationAddresses;
//
//                            console.log("origins: " + origins);
//                            console.log("destinations: " + destinations);
//
//                            // we only ever provide one origin
//                            for (var i = 0; i < origins.length; i++) {
//                                var results = response.rows[i].elements;
//                                for (var j = 0; j < results.length; j++) {
//                                    var element = results[j];
//                                    var distance = element.distance.text;
//                                    var duration = element.duration.text;
//                                    var distance_raw = element.distance.value;
//                                    var duration_raw = element.duration.value;
//                                    var from = origins[i];
//                                    var to = destinations[j];
//
//                                    console.log("from: " + from + " to: " + to + " distance: " + distance + " (" + distance_raw + " meters) duration: " + duration + " (" + duration_raw + " secs)");
//
//                                    if (distance_raw < TOO_FAR_AWAY) {
//                                        console.log("Geocoding stockist: " + to);
//                                        geocoder.geocode({'address': to}, function(results, status) {
//                                            if (status == google.maps.GeocoderStatus.OK) {
//
//                                                var stockist_latlong = results[0].geometry.location
//                                                var stockist_address = results[0].formatted_address
//
//                                                console.log("stockist_latlong: " + stockist_latlong.toUrlValue(2));
//
//                                                marker = new google.maps.Marker({
//                                                    position: stockist_latlong,
//                                                    title: stockist_address,
//                                                    map: map
//                                                });
//                                            }
//                                        })
//                                    }
//                                }
//                            }
//                        }
//
//                    }
//                );

            } else {
                alert("We were unable to geolocate your position from the address provided, please try again: " + status);
            }
        });


        return false;
    });


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
        jQuery('#address').val(init_lat + "," + init_long);

        var latlng = new google.maps.LatLng(init_lat, init_long);


    }
}