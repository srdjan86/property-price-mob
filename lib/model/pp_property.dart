import 'dart:convert';

import 'package:property_price_mob/model/pp_location.dart';

class PPProperty {
  final int id;
  final int size;
  final int landSize;
  final String type;
  final String typeFormated;
  final PPLocation location;

  PPProperty({
    this.id,
    this.size,
    this.landSize,
    this.type,
    this.typeFormated,
    this.location,
  });

  PPProperty.fromJSON(Map<String, dynamic> json)
      : this(
          id: json['id'],
          size: json['size'],
          landSize: json['landSize'],
          type: json['type'],
          typeFormated: json['typeFormated'],
          location: PPLocation.fromJSON(json['location']),
        );

  static List<PPProperty> fromJSONList(json) {
    List<PPProperty> properties =
        List<PPProperty>.from(json.map((i) => PPProperty.fromJSON(i)));
    return properties;
  }
}
