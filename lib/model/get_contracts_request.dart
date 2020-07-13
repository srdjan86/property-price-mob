import 'package:property_price_mob/utils/pp_datetime.dart';

class GetContractsRequest {
  final int propertyTypeId;
  final DateFilter dateFilter;
  PriceFilter priceFilter;
  SizeFilter sizeFilter;

  GetContractsRequest({
    this.dateFilter,
    this.priceFilter,
    this.sizeFilter,
    this.propertyTypeId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['typeId'] = propertyTypeId;
    map['filters'] = Map<String, dynamic>();
    if (dateFilter != null) {
      map['filters'][dateFilter.name] = dateFilter.toJson();
    }
    if (priceFilter != null) {
      map['filters'][priceFilter.name] = priceFilter.toJson();
    }
    if (sizeFilter != null) {
      map['filters'][sizeFilter.name] = sizeFilter.toJson();
    }
    return map;
  }
}

abstract class BaseFilter {
  String name;
  final dynamic min;
  final dynamic max;

  BaseFilter({this.min, this.max});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map<String, dynamic>();
    if (min != null) {
      map['min'] = min;
    }
    if (max != null) {
      map['max'] = max;
    }
    return map;
  }
}

class DateFilter extends BaseFilter {
  final String name = 'date';

  DateFilter({min, max}) : super(min: min, max: max);

  Map<String, dynamic> toJson() => {
        'min': PPDateTime.toUSString(min),
        'max': PPDateTime.toUSString(max),
      };
}

class PriceFilter extends BaseFilter {
  final String name = 'price';

  PriceFilter({min, max}) : super(min: min, max: max);
}

class SizeFilter extends BaseFilter {
  final String name = 'size';

  SizeFilter({min, max}) : super(min: min, max: max);
}
