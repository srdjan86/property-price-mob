import 'package:property_price_mob/model/pp_property.dart';

class Contract {
  final int id;
  final int price;
  final String priceCurrency;
  final String date;
  final String type;
  final String object;
  final List<PPProperty> properties;

  Contract({
    this.id,
    this.price,
    this.priceCurrency,
    this.date,
    this.type,
    this.object,
    this.properties,
  });

  Contract.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          price: json['price'],
          priceCurrency: json['priceCurrency'],
          date: json['date'],
          type: json['type'],
          object: json['object'],
          properties: PPProperty.fromJSONList(json['properties']),
        );
}
