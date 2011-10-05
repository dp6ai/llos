var TOO_FAR_AWAY = 30 * 1000;

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


    var lat;
    var longi;
    var latlng;
    var myOptions;
    var marker;
    var map;

    jQuery(".stockist").each(function(index) {

        console.log(jQuery(this));

        lat = jQuery(this).children("dl").find(".lat").text();
        longi = jQuery(this).children("dl").find(".long").text();

        console.log("lat: " + lat + " long: " + longi);

        latlng = new google.maps.LatLng(lat, longi);

        console.log("latlng: " + latlng);

        myOptions = {
            zoom: 15,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        if (jQuery(this).find(".map_canvas").length > 0) {
            map = new google.maps.Map(jQuery(this).find(".map_canvas")[0], myOptions);

            marker = new google.maps.Marker({
                position: latlng,
                title: jQuery(this).find(".name").text(),
                map: map
                //,icon: '/images/mainlogo-small.png'
            });
        }
    });


    var init_lat;
    var init_long;

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

    jQuery('#stockist_form').submit(function() {
        var address = jQuery("input:first").val();
        console.log('Handler for .submit() called : ' + address);

        var geocoder = new google.maps.Geocoder();
        var distance_service = new google.maps.DistanceMatrixService();

        var stockists = [];
        var filtered_stockists = [];
        var stockist = {};

        // collect all the stockists
        jQuery("dl").each(function(index) {
            console.log(jQuery(this));

            stockist = {};
            stockist.name = jQuery(this).find(".name").text();
            stockist.lat = jQuery(this).find(".lat").text();
            stockist.longi = jQuery(this).find(".long").text();
            stockist.latlong = new google.maps.LatLng(stockist.lat, stockist.longi);

            stockists[index] = stockist;
        })

        // Geocode whatever we have for the users address

        var myOptions = {
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(jQuery("#results_canvas")[0], myOptions);
        var marker;
        var origin;

        geocoder.geocode({'address': address}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {

                origin = results[0].geometry.location
                console.log("OK : " + origin);

                map.setCenter(origin);

                marker = new google.maps.Marker({
                    position: origin,
                    title: "your current location " + address,
                    map: map
                });


                jQuery.each(stockists, function(index, value) {
                    console.log("name: " + stockists[index].name + " lat: " + stockists[index].lat + " long: " + stockists[index].longi + " latlong: " + stockists[index].latlong);
                    filtered_stockists[index] = stockists[index].latlong;
                })

                distance_service.getDistanceMatrix({
                        origins: [origin],
                        destinations: filtered_stockists,
                        travelMode: google.maps.TravelMode.DRIVING,
                        avoidHighways: false,
                        avoidTolls: false }, function (response, status) {

                        if (status == google.maps.DistanceMatrixStatus.OK) {
                            var origins = response.originAddresses;
                            var destinations = response.destinationAddresses;

                            console.log("origins: "+origins);
                            console.log("destinations: "+destinations);

//                            filtered_stockists = {}

                            for (var i = 0; i < origins.length; i++) {
                                var results = response.rows[i].elements;
                                for (var j = 0; j < results.length; j++) {
                                    var element = results[j];
                                    var distance = element.distance.text;
                                    var duration = element.duration.text;
                                    var distance_raw = element.distance.value;
                                    var duration_raw = element.duration.value;
                                    var from = origins[i];
                                    var to = destinations[j];

                                    console.log("from: " + from + " to: " + to + " distance: " + distance + " ("+ distance_raw +" meters) duration: " + duration + " (" + duration_raw+ " secs)");

                                    if (distance_raw < TOO_FAR_AWAY) {
                                        console.log("Geocoding stockist: " + to);
                                        geocoder.geocode({'address': to}, function(results, status) {
                                            if (status == google.maps.GeocoderStatus.OK) {

                                                var stockist_latlong = results[0].geometry.location
                                                var stockist_address = results[0].formatted_address
                                                console.log("OK stockist: "+" "+ stockist_address);

                                                marker = new google.maps.Marker({
                                                    position: stockist_latlong,
                                                    title: stockist_address,
                                                    map: map
                                                });
                                            }
                                        })
                                    }
                                }
                            }
                        }

                    }
                );

            } else {
                alert("We were unable to geolocate your position from the address provided, please try again: " + status);
            }
        });


        return false;
    });


});

// END DOC READY


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

        var myOptions = {
            zoom: 15,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(jQuery("#user_canvas")[0], myOptions);

        var marker = new google.maps.Marker({
            position: latlng,
            title: "Current location",
            map: map
        });

    }
}