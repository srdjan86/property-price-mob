import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:latlong/latlong.dart';

class PPMarker extends Marker {
  final List<Contract> contracts;
  final LatLng point;
  final WidgetBuilder builder;

  PPMarker({this.contracts, this.point, this.builder})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          point: point,
          builder: builder,
        );
}
