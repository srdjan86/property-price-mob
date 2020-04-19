import 'package:property_price_mob/model/district.dart';

class GetDistrictsUseCase {
  Future<List<District>> getAllDistricts() async {
    // dio.get(path)
    Map<String, String> jsonResponse = {'main': '1', 'sub': '2'};
    List<District> list = District.fromJSON(jsonResponse);
    return list;
  }
}
