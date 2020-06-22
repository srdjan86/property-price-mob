import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong/latlong.dart';
import 'package:property_price_mob/model/pp_marker.dart';
import 'package:property_price_mob/ui/app/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class PPMap extends StatefulWidget {
  const PPMap({Key key}) : super(key: key);

  @override
  _PPMapState createState() => _PPMapState();
}

class _PPMapState extends State<PPMap> {
  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        plugins: [PopupMarkerPlugin()],
        onTap: (_) => _popupLayerController.hidePopup(),
        center: LatLng(44.7866, 20.4489),
        // interactive: true,
        maxZoom: 18,
        zoom: 12.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        PopupMarkerLayerOptions(
          markers: _createMarkers(context),
          popupSnap: PopupSnap.top,
          popupController: _popupLayerController,
          popupBuilder: (BuildContext _, Marker marker) {
            if (marker is PPMarker) {
              return Container(
                color: Colors.white,
                height: 100,
                width: 400,
                child: ListView.builder(
                  itemCount: marker.contracts.length,
                  itemBuilder: (context, i) => Column(
                    children: <Widget>[
                      Text(
                          'price ${marker.contracts[i].price} ${marker.contracts[i].priceCurrency}'),
                      Text('date ${marker.contracts[i].date}'),
                      Text(marker.contracts[i].object),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: marker.contracts[i].properties.length,
                        itemBuilder: (context, ind) => Row(
                          children: <Widget>[
                            Text('$ind. '),
                            Column(
                              children: <Widget>[
                                Text(
                                  'Property type: ${marker.contracts[i].properties[ind].type}',
                                ),
                                Text(
                                    'Property size: ${marker.contracts[i].properties[ind].size}'),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }

  List<Marker> _createMarkers(BuildContext context) {
    HomeViewModel homeViewmodel = Provider.of(context);

    return homeViewmodel.markers;
  }
}
