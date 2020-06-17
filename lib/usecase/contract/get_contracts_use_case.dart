import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:property_price_mob/usecase/dio.dart';
import 'package:property_price_mob/utils/contants/api.dart';
import 'package:property_price_mob/utils/pp_datetime.dart';

class GetContractsUseCase {
  Dio dio = CustomDio().instance.dio;

  getContracts(DateTime startDate, DateTime endDate) async {
    print('${startDate.year}-${startDate.month}-${startDate.day}');
    print('${endDate.year}-${endDate.month}-${endDate.day}');
    print(PPDateTime.toUSString(startDate));
    print(PPDateTime.toUSString(endDate));

    final result = await dio.post(Api.CONTRACTS_ENDPOINT, data: {
      'dateStart': PPDateTime.toUSString(startDate),
      'dateEnd': PPDateTime.toUSString(endDate),
    });

    // final decoded = jsonDecode(result.data);
    for (var contract in result.data['data']) {
      print(contract);
    }
  }
}
