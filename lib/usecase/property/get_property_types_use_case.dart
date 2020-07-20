import 'package:dio/dio.dart';
import 'package:property_price_mob/model/data_result.dart';
import 'package:property_price_mob/model/property_type.dart';
import 'package:property_price_mob/usecase/dio.dart';
import 'package:property_price_mob/utils/contants/api.dart';

class GetPropertyTypesUseCase {
  Future<DataResult<List<PropertyCategory>>> getPropertyTypes() async {
    try {
      Dio dio = CustomDio().instance.dio;
      List<PropertyCategory> list = List<PropertyCategory>();
      // dio.get(path)
      final result = await dio.get(Api.PROPERTY_TYPES_ENDPOINT);

      result.data['data'].forEach((json) {
        json['id'] = list.length;
        PropertyCategory propertyCategory = PropertyCategory.fromJson(json);
        list.add(propertyCategory);
      });
      return DataResult.success(list);
    } catch (e) {
      print(e);
      return DataResult.failure(e);
    }
  }
}
