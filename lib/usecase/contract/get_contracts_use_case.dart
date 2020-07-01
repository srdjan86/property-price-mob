import 'package:dio/dio.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/model/data_result.dart';
import 'package:property_price_mob/model/get_contracts_request.dart';
import 'package:property_price_mob/usecase/dio.dart';
import 'package:property_price_mob/utils/contants/api.dart';

class GetContractsUseCase {
  Dio dio = CustomDio().instance.dio;

  Future<DataResult<List<Contract>>> getContracts(
      GetContractsRequest request) async {
    try {
      print(request.toJson());
      final result = await dio
          .post(Api.CONTRACTS_ENDPOINT, data: {'filters': request.toJson()});
      print('getContracts result: $result');
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
