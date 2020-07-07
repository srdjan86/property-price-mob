import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/model/pp_marker.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:latlong/latlong.dart';
import 'package:property_price_mob/utils/contants/mapbox_fields.dart';

class PPMapViewModel extends BaseViewModel {
  Map<String, PPMarker> markersMap = new Map();
  List<PPMarker> markers = List<PPMarker>();

  String _selectedMarkerId;
  MapController controller = new MapController();
  String _mapId = MapBoxFields.streetsId;

  String get mapId => _mapId;
  set mapId(String value) {
    _mapId = value;
    forceNotify();
  }

  String get selectedMarkerId => _selectedMarkerId;
  set selectedMarkerId(String value) {
    _selectedMarkerId = value;
    forceNotify();
  }

  void createLocations(List<Contract> contracts) {
    markersMap = new Map();
    markers = new List<PPMarker>();
    for (var contract in contracts) {
      for (var property in contract.properties) {
        final key = property.location.lat.toString() +
            '-' +
            property.location.lon.toString();
        if (markersMap[key] == null) {
          markersMap[key] = PPMarker(
            id: key,
            contracts: [contract],
            point: LatLng(property.location.lat, property.location.lon),
            onTap: () {
              selectedMarkerId = key;
              forceNotify();
            },
          );
        } else {
          if ((markersMap[key].contracts.singleWhere((c) => c.id == contract.id,
                  orElse: () => null)) !=
              null) {
          } else {
            markersMap[key].contracts.add(contract);
          }
        }
      }
    }
    markersMap.forEach((k, v) => markers.add(v));
    if (markers.length > 0) {
      _setMapFitToTour();
    }
    forceNotify();
  }

  void _setMapFitToTour() {
    double minLat = markers.first.point.latitude;
    double minLong = markers.first.point.longitude;
    double maxLat = markers.first.point.latitude;
    double maxLong = markers.first.point.longitude;
    print(markers.length);
    markers.forEach((marker) {
      marker.contracts.forEach((contract) {
        contract.properties.forEach((property) {
          if (property.location.lat < minLat) minLat = property.location.lat;
          if (property.location.lat > maxLat) maxLat = property.location.lat;
          if (property.location.lon < minLong) minLong = property.location.lon;
          if (property.location.lon > maxLong) maxLong = property.location.lon;
        });
      });
    });
    controller.onReady.then((value) {
      var bounds = LatLngBounds();
      bounds.extend(LatLng(minLat, minLong));
      bounds.extend(LatLng(maxLat, maxLong));

      controller.fitBounds(
        bounds,
        options: FitBoundsOptions(
          padding: EdgeInsets.all(30),
        ),
      );
    });
  }
}
