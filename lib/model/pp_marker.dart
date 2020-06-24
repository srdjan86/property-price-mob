import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:latlong/latlong.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_viewmodel.dart';
import 'package:provider/provider.dart';

class PPMarker extends Marker {
  final String id;
  final List<Contract> contracts;
  final LatLng point;

  final Function onTap;

  PPMarker({
    this.id,
    this.contracts,
    this.point,
    this.onTap,
  }) : super(
            anchorPos: AnchorPos.align(AnchorAlign.top),
            point: point,
            builder: (context) {
              PPMapViewModel mapViewmodel = Provider.of(context);
              return GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  'assets/images/residence-512.png',
                  height: 10,
                  width: 10,
                  color: mapViewmodel.selectedMarkerId == id
                      ? Colors.blue
                      : Colors.black,
                ),
              );
            });
}
