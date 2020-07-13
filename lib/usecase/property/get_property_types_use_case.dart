import 'package:dio/dio.dart';
import 'package:property_price_mob/model/data_result.dart';
import 'package:property_price_mob/model/property_type.dart';
import 'package:property_price_mob/usecase/dio.dart';
import 'package:property_price_mob/utils/contants/api.dart';

class GetPropertyTypesUseCase {
  Future<DataResult<List<PropertyType>>> getPropertyTypes() async {
    try {
      Dio dio = CustomDio().instance.dio;
      List<PropertyType> list = List<PropertyType>();
      // dio.get(path)
      final result = await dio.get(Api.PROPERTY_TYPES_ENDPOINT);
      for (var json in result.data['data']) {
        PropertyType propertyType = PropertyType.fromJson(json);
        list.add(propertyType);
      }
      return DataResult.success(list);
    } catch (e) {
      print(e);
      return DataResult.failure(e);
    }
  }
}
