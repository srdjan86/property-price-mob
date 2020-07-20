import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/model/data_result.dart';
import 'package:property_price_mob/model/get_contracts_request.dart';
import 'package:property_price_mob/model/property_type.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:property_price_mob/usecase/contract/get_contracts_use_case.dart';
import 'package:property_price_mob/usecase/property/get_property_types_use_case.dart';

class HomeViewModel extends BaseViewModel {
  final GetContractsUseCase _getContractsUseCase;
  final GetPropertyTypesUseCase _getPropertyTypesUseCase;

  HomeViewModel(this._getContractsUseCase, this._getPropertyTypesUseCase);

  List<Contract> contracts;

  List<PropertyCategory> propertyCategories = List<PropertyCategory>();

  Future<bool> getContracts(GetContractsRequest request) async {
    contracts = List<Contract>();
    forceNotify();
    DataResult result = await load(_getContractsUseCase.getContracts(request));
    if (!result.isFailure()) {
      contracts = result.data;
      forceNotify();
      return true;
    } else {
      error = 'An error occured while getting contracts.';
      return false;
    }
  }

  Future<bool> getPropertyTypes() async {
    DataResult result = await load(_getPropertyTypesUseCase.getPropertyTypes());
    if (!result.isFailure()) {
      propertyCategories = result.data;
    } else {
      error = 'An error occurred while getting property types.';
    }
    return true;
  }
}
