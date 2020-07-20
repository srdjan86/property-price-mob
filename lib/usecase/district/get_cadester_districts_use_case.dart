import 'package:dio/dio.dart';
import 'package:property_price_mob/model/cadesterDistrict.dart';
import 'package:property_price_mob/model/data_result.dart';
import 'package:property_price_mob/utils/contants/api.dart';

import '../dio.dart';

class GetCadesterDistrictsUseCase {
  Dio dio = CustomDio().instance.dio;

  Future<DataResult<List<CadesterDistrict>>> getCadesterDistricts(
      String district) async {
    try {
      final result = await dio
          .post(Api.CADESTER_DISTRICTS_ENDPOINT, data: {"district": district});
      List<CadesterDistrict> cadesterDistricts = List<CadesterDistrict>();
      for (var json in result.data['data']) {
        CadesterDistrict cadesterDistrict = CadesterDistrict.fromJson(json);
        cadesterDistricts.add(cadesterDistrict);
      }
      return DataResult.success(cadesterDistricts);
    } catch (e) {
      print(e);
      return DataResult.failure(e);
    }
  }
}
