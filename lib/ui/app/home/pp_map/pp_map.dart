import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/ui/app/home/home_viewmodel.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_popup.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_viewmodel.dart';
import 'package:property_price_mob/utils/contants/mapbox_fields.dart';
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
    print('mapbuild');
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
            urlTemplate:
                "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoidmFuaWxpY2EiLCJhIjoiY2tiY2JpN21zMDBkOTMwb2E3ZXU2dzJ3NiJ9.YpAx8SgVmi6W6N9jkaCYbw',
              'id': 'mapbox/${viewmodel.mapId}',
            },
          ),
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
      ),
      Positioned(
        bottom: 0,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: FloatingActionButton(
                child: viewmodel.mapId == MapBoxFields.streetsId
                    ? Icon(Icons.streetview)
                    : Icon(Icons.satellite),
                onPressed: () {
                  if (viewmodel.mapId == MapBoxFields.streetsId) {
                    viewmodel.mapId = MapBoxFields.satelliteStreetsId;
                  } else {
                    viewmodel.mapId = MapBoxFields.streetsId;
                  }
                }),
          ),
        ),
      ),
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
