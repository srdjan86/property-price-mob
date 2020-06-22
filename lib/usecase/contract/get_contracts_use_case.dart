import 'package:dio/dio.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/model/data_result.dart';
import 'package:property_price_mob/usecase/dio.dart';
import 'package:property_price_mob/utils/contants/api.dart';
import 'package:property_price_mob/utils/pp_datetime.dart';

class GetContractsUseCase {
  Dio dio = CustomDio().instance.dio;

  Future<DataResult<List<Contract>>> getContracts(
      DateTime startDate, DateTime endDate) async {
    try {
      final result = await dio.post(Api.CONTRACTS_ENDPOINT, data: {
        'dateStart': PPDateTime.toUSString(startDate),
        'dateEnd': PPDateTime.toUSString(endDate),
      });

      final contracts = List<Contract>();
      for (var con in result.data['data']) {
        final contract = Contract.fromJson(con);
        contracts.add(contract);
      }
      return DataResult.success(contracts);
    } catch (e) {
      print(e);
      return DataResult.failure(e);
    }
  }
}
