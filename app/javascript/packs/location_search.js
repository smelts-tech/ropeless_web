window.initMap = function (lat, lng, markers) {
    var myCoords = new google.maps.LatLng(lat, lng);
    var mapOptions = {
        center: myCoords,
        zoom: 14,
        mapTypeId: 'satellite'
    };
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    // markers
    for (var i = 0; i < markers.length; i++) {
        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(markers[i]['lat'], markers[i]['lng']),
            map: map
        });
        // process multiple info windows
        (function(marker, i) {
            // add click event
            google.maps.event.addListener(marker, 'click', function() {
                infowindow = new google.maps.InfoWindow({
                    content: '<b>Modem ID:</b>' + markers[i]['modem_id'] + '<br/>' +
                        '<b>Event Type:</b>' + markers[i]['event_type'] + '<br/>' +
                        '<b>Event Time:</b>' + markers[i]['device_event_time'] + '<br/>' +
                        '<b>Latitude:</b>' + markers[i]['lat'] + '<br/>' +
                        '<b>Longitude:</b>' + markers[i]['lng'] + '<br/>' +
                        '<b>Depth:</b>' + markers[i]['depth'] + '<br/>' +
                        '<b>Altitude:</b>' + markers[i]['altitude'] + '<br/>'

                });
                infowindow.open(map, marker);
            });
        })(marker, i);
    }
}
