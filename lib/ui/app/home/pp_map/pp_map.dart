import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:property_price_mob/ui/app/home/home_viewmodel.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_popup.dart';
import 'package:provider/provider.dart';

class PPMap extends StatefulWidget {
  const PPMap({Key key}) : super(key: key);

  @override
  _PPMapState createState() => _PPMapState();
}

class _PPMapState extends State<PPMap> {
  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewmodel = Provider.of(context);
    return Stack(children: [
      FlutterMap(
        options: MapOptions(
          onTap: (_) {
            print('mapTapped');
            homeViewmodel.selectedMarkerId = null;
          },
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
            markers: homeViewmodel.markers,
          )
        ],
      ),
      homeViewmodel.selectedMarkerId != null
          ? PPMapPopup(
              contracts: homeViewmodel
                  .markersMap[homeViewmodel.selectedMarkerId].contracts,
            )
          : Container()
    ]);
  }
}
