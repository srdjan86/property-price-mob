import 'package:dio/dio.dart';
import 'package:property_price_mob/model/data_result.dart';
import 'package:property_price_mob/model/district.dart';
import 'package:property_price_mob/utils/contants/api.dart';

import '../dio.dart';

class GetDistrictsUseCase {
  Dio dio = CustomDio().instance.dio;

  Future<DataResult<List<District>>> getDistricts() async {
    try {
      final result = await dio.get(Api.DISTRICTS_ENDPOINT);
      List<District> districts = List<District>();
      for (var json in result.data['data']) {
        json['id'] = districts.length;
        District district = District.fromJson(json);
        districts.add(district);
      }
      return DataResult.success(districts);
    } catch (e) {
      print(e);
      return DataResult.failure(e);
    }
  }
}
