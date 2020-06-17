import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong/latlong.dart';

class PPMap extends StatelessWidget {
  const PPMap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopupController _popupController = PopupController();
    return new FlutterMap(
      options: new MapOptions(
        plugins: [PopupMarkerPlugin()],
        onTap: (_) => _popupController.hidePopup(),
        center: new LatLng(44.7866, 20.4489),
        // interactive: true,
        maxZoom: 18,
        zoom: 12.0,
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              // width: 80.0,
              // height: 80.0,
              point: new LatLng(44.828190, 20.415110),
              builder: (ctx) => new Container(
                child: new Image.asset('assets/images/residence-512.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }
  // Widget build(BuildContext context) {
  //   return new FlutterMap(
  //     options: new MapOptions(
  //       // center: new LatLng(51.5, -0.09),
  //       zoom: 13.0,
  //     ),
  //     layers: [
  //       new TileLayerOptions(
  //         urlTemplate: "https://api.mapbox.com/v4/"
  //             "{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoidmFuaWxpY2EiLCJhIjoiY2tiYzkyZjh0MDhrczJxbjB5anEwbGI5byJ9.kojkghBtVvXPBiK7c3UYMQ",
  //         additionalOptions: {
  //           'accessToken':
  //               'pk.eyJ1IjoidmFuaWxpY2EiLCJhIjoiY2tiYzkyZjh0MDhrczJxbjB5anEwbGI5byJ9.kojkghBtVvXPBiK7c3UYMQ',
  //           'id': 'mapbox.streets',
  //         },
  //       ),
  //       new MarkerLayerOptions(
  //         markers: [
  //           new Marker(
  //             width: 80.0,
  //             height: 80.0,
  //             // point: new LatLng(51.5, -0.09),
  //             builder: (ctx) => new Container(
  //               child: new FlutterLogo(),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
