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
        lat = markers[i][0];
        lng = markers[i][1];
        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(lat, lng),
            map: map
        });
        // process multiple info windows
        (function(marker, i) {
            // add click event
            google.maps.event.addListener(marker, 'click', function() {
                infowindow = new google.maps.InfoWindow({
                    content: 'Modem ID:' + markers[i][2]
                });
                infowindow.open(map, marker);
            });
        })(marker, i);
    }
}
