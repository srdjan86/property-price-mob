import 'package:flutter_map/flutter_map.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:latlong/latlong.dart';
import 'package:property_price_mob/ui/common/pp_marker_widget.dart';

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
            return PPMarkerWidget(onTap: onTap, id: id);
          },
        );
}
