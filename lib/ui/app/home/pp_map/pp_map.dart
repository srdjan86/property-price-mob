import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong/latlong.dart';
import 'package:property_price_mob/ui/app/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class PPMap extends StatelessWidget {
  const PPMap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopupController _popupController = PopupController();
    return FlutterMap(
      options: MapOptions(
        plugins: [PopupMarkerPlugin()],
        onTap: (_) => _popupController.hidePopup(),
        center: LatLng(44.7866, 20.4489),
        // interactive: true,
        maxZoom: 18,
        zoom: 12.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(markers: _createMarkers(context)),
      ],
    );
  }

  List<Marker> _createMarkers(BuildContext context) {
    HomeViewModel homeViewmodel = Provider.of(context);
    List<Marker> markers = new List<Marker>();
    final contracts = homeViewmodel.contracts;
    for (var contract in contracts) {
      for (var property in contract.properties) {
        final marker = Marker(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          point: LatLng(property.location.lat, property.location.lon),
          builder: (ctx) => Image.asset(
            'assets/images/residence-512.png',
            height: 10,
            width: 10,
          ),
        );
        markers.add(marker);
      }
    }
    return markers;
  }
}
