import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:property_price_mob/usecase/contract/get_contracts_use_case.dart';

class HomeViewModel extends BaseViewModel {
  final GetContractsUseCase _getContractsUseCase;

  HomeViewModel(this._getContractsUseCase);

  List<Contract> contracts;

  Future<bool> getContracts(DateTime startDate, DateTime endDate) async {
    final result =
        await load(_getContractsUseCase.getContracts(startDate, endDate));
    if (!result.isFailure()) {
      contracts = result.data;
      forceNotify();
      return true;
    } else {
      error = 'An error occured while getting contracts.';
      return false;
    }
  }
}
