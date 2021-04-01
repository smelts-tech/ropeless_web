window.initMap = function(lat, lng, markers) {
    // mouse position code start
    L.Control.MousePosition = L.Control.extend({
        options: {
            position: 'bottomleft',
            separator: ' : ',
            emptyString: 'Unavailable',
            lngFirst: false,
            numDigits: 5,
            lngFormatter: undefined,
            latFormatter: undefined,
            prefix: ""
        },

        onAdd: function (map) {
            this._container = L.DomUtil.create('div', 'leaflet-control-mouseposition');
            L.DomEvent.disableClickPropagation(this._container);
            map.on('mousemove', this._onMouseMove, this);
            this._container.innerHTML=this.options.emptyString;
            return this._container;
        },

        onRemove: function (map) {
            map.off('mousemove', this._onMouseMove)
        },

        _onMouseMove: function (e) {
            var lng = this.options.lngFormatter ? this.options.lngFormatter(e.latlng.lng) : L.Util.formatNum(e.latlng.lng, this.options.numDigits);
            var lat = this.options.latFormatter ? this.options.latFormatter(e.latlng.lat) : L.Util.formatNum(e.latlng.lat, this.options.numDigits);
            var value = this.options.lngFirst ? lng + this.options.separator + lat : lat + this.options.separator + lng;
            var prefixAndValue = this.options.prefix + ' ' + value;
            this._container.innerHTML = prefixAndValue;
        }

    });

    L.Map.mergeOptions({
        positionControl: false
    });

    L.Map.addInitHook(function () {
        if (this.options.positionControl) {
            this.positionControl = new L.Control.MousePosition();
            this.addControl(this.positionControl);
        }
    });

    L.control.mousePosition = function (options) {
        return new L.Control.MousePosition(options);
    };

    // mouse position code end

    var loc = {'lat': lat, 'lon': lng},
              zoomLevel = 13

          //instantiate the map:
          var map = L.map('map', {
              fullscreenControl: true
          });

          esriOceans = L.esri.basemapLayer("Oceans").addTo(map).bringToBack();

          /* HAVEN'T FIGURE THIS OUT YET, BUT WOULD BE NICE.

          var merged_wrecks_service_url = "https://wrecks.nauticalcharts.noaa.gov/arcgis/rest/services/public_wrecks/Wrecks_And_Obstructions/MapServer";

          //add the AWOIS/ENC wrecks and obstructions layers:
          var awoisObstructions = addDynamicMapLayer(map, "AWOIS Obstructions", merged_wrecks_service_url,
              {layers: [5], position: "front", format: 'png32'},
              {"Record": "recrd", "Vesselterms:": "vesslterms", "Type": "feature_type", "Latitude": "latdec", "Longitude": "londec", "Positional Accuracy": "gp_quality", "Year Sunk": "yearsunk", "Depth": "depth", "Depth Units": "sounding_type", "History": "history"}
          );
          var encWrecks = addDynamicMapLayer(map, "ENC Wrecks", merged_wrecks_service_url,
              {layers: [10], position: "front", format: 'png32'},
              {"Vesselterms:": "vesslterms", "Type": "feature_type", "Latitude": "latdec", "Longitude": "londec", "Year Sunk": "yearsunk", "Depth": "depth", "History": "history", "Sounding Quality": "quasou", "Water Level Effect": "watlev"}
          );
          var awoisWrecks = addDynamicMapLayer(map, "AWOIS Wrecks", merged_wrecks_service_url,
              {layers: [0], position: "front", format: 'png32'},
              {"Record": "recrd", "Vesselterms:": "vesslterms", "Type": "feature_type", "Latitude": "latdec", "Longitude": "londec", "Positional Accuracy": "gp_quality", "Year Sunk": "yearsunk", "Depth": "depth", "Depth Units": "sounding_type", "History": "history"}
          );

          var encBoundaries = L.esri.dynamicMapLayer(merged_wrecks_service_url, {
              layers: [15,16,17,18,19],
              format: "png32",
              position: "back"
          });
          var maritimeBoundaries = L.esri.dynamicMapLayer("https://maritimeboundaries.noaa.gov/arcgis/rest/services/MaritimeBoundaries/US_Maritime_Limits_Boundaries/MapServer", {
              position: "front"
          }).addTo(map);

          var sanctuariesBoundaries = L.esri.dynamicMapLayer("https://new.nowcoast.noaa.gov/arcgis/rest/services/nowcoast/mapoverlays_political/MapServer", {
              layers: [0],
              format: "png32",
              position: "front"
          });

          var seamlessRaster = L.esri.dynamicMapLayer("https://seamlessrnc.nauticalcharts.noaa.gov/arcgis/rest/services/RNC/NOAA_RNC/MapServer", {
              layers: [1,2,3],
              format: "png24",
              position: "back"
          });

          var overlayMaps = {
              "AWOIS Wrecks": awoisWrecks,
              "ENC Wrecks": encWrecks,
              "AWOIS Obstructions": awoisObstructions,
              "ENC Boundaries": encBoundaries,
              "US Maritime Boundaries": maritimeBoundaries,
              "US Marine Sanctuaries": sanctuariesBoundaries,
              "NOAA Nautical Charts": seamlessRaster
          };

          var layerVisHash = {
              "AWOIS Wrecks": true,
              "ENC Wrecks": true,
              "AWOIS Obstructions": true,
              "ENC Boundaries": true,
              "US Maritime Boundaries": true,
              "US Marine Sanctuaries": true,
              "NOAA Nautical Charts": true
          };
          map.layerVis = layerVisHash;

          //add the Layers control to the map:
          var layerControl = L.control.layers(overlayMaps, {
              collapsed: false
          }).addTo(map);
          map.on("overlayadd", function(e) {
              //console.log("layer: " + e.name + " was added.");
              map.layerVis[e.name] = true;
          });
          map.on("overlayremove", function(e) {
              //console.log("layer: " + e.name + " was removed.");
              map.layerVis[e.name] = false;
          });
*/

          //add scale control:
          L.control.scale().addTo(map);
          //MousePosition:
          L.control.mousePosition().addTo(map);

    // markers
    for (var i = 0; i < markers.length; i++) {
        var marker = L.marker([markers[i]['lat'], markers[i]['lng']]).addTo(map);

        // process multiple info windows
        (function(marker, i) {
            marker.bindPopup('<b>Modem ID:</b>' + markers[i]['modem_id'] + '<br/>' +
                '<b>Event Type:</b>' + markers[i]['event_type'] + '<br/>' +
                '<b>Event Time:</b>' + markers[i]['device_event_time'] + '<br/>' +
                '<b>Latitude:</b>' + markers[i]['lat'] + '<br/>' +
                '<b>Longitude:</b>' + markers[i]['lng'] + '<br/>' +
                '<b>Depth:</b>' + markers[i]['depth'] + '<br/>' +
                '<b>Altitude:</b>' + markers[i]['altitude'] + '<br/>').openPopup();
        })(marker, i);
    }

    map.setView(
        [loc.lat, loc.lon],
        zoomLevel
    );
}