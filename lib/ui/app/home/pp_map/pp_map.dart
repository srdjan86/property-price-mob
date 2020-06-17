import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong/latlong.dart';

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
        MarkerLayerOptions(
          markers: [
            Marker(
              anchorPos: AnchorPos.align(AnchorAlign.top),
              point: LatLng(44.828190, 20.415110),
              builder: (ctx) => Image.asset(
                'assets/images/residence-512.png',
                height: 10,
                width: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
