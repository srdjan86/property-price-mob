import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/ui/app/home/home_viewmodel.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_popup.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_viewmodel.dart';
import 'package:provider/provider.dart';

class PPMap extends StatefulWidget {
  final List<Contract> contracts;
  const PPMap({Key key, this.contracts}) : super(key: key);

  @override
  _PPMapState createState() => _PPMapState();
}

class _PPMapState extends State<PPMap> {
  @override
  Widget build(BuildContext context) {
    PPMapViewModel viewmodel = Provider.of(context);
    return Stack(children: [
      FlutterMap(
        mapController: viewmodel.controller,
        options: MapOptions(
          onTap: (_) {
            if (viewmodel.selectedMarkerId != null) {
              viewmodel.selectedMarkerId = null;
            }
          },
          center: LatLng(44.7866, 20.4489),
          // interactive: true,
          maxZoom: 18,
          zoom: 12.0,
          plugins: [
            MarkerClusterPlugin(),
          ],
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerClusterLayerOptions(
            maxClusterRadius: 30,
            size: Size(40, 40),
            anchor: AnchorPos.align(AnchorAlign.center),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: List.from(viewmodel.markers),
            polygonOptions: PolygonOptions(
                borderColor: Colors.black,
                color: Colors.black12,
                borderStrokeWidth: 3),
            builder: (context, markers) {
              return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: null,
                backgroundColor: Colors.black,
              );
            },
          ),
        ],
      ),
      PPMapPopup(
        contracts: viewmodel.selectedMarkerId != null
            ? viewmodel.markersMap[viewmodel.selectedMarkerId].contracts
            : null,
      )
    ]);
  }

  @override
  void didUpdateWidget(PPMap oldWidget) {
    HomeViewModel homeViewmodel = Provider.of(context);
    if (homeViewmodel.contracts != null) {
      PPMapViewModel viewmodel = Provider.of(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewmodel.selectedMarkerId = null;
        // if (homeViewmodel.contracts.length > 0) {
        viewmodel.createLocations(homeViewmodel.contracts);
        // }
      });
    }

    super.didUpdateWidget(oldWidget);
  }
}
