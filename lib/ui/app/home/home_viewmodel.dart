import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:property_price_mob/usecase/contract/get_contracts_use_case.dart';

class HomeViewModel extends BaseViewModel {
  final GetContractsUseCase _getContractsUseCase;

  HomeViewModel(this._getContractsUseCase);

  void getContracts(DateTime startDate, DateTime endDate) async {
    await _getContractsUseCase.getContracts(startDate, endDate);
  }

  @override
  void init() {}
}
