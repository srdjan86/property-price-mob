import 'package:flutter/material.dart';
import 'package:property_price_mob/model/cadesterDistrict.dart';
import 'package:property_price_mob/model/data_result.dart';
import 'package:property_price_mob/model/district.dart';
import 'package:property_price_mob/model/get_contracts_request.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:property_price_mob/usecase/district/get_cadester_districts_use_case.dart';
import 'package:property_price_mob/usecase/district/get_districts_use_case.dart';
import 'package:property_price_mob/utils/pp_datetime.dart';

class SidebarViewModel extends BaseViewModel {
  int _selectedCategory;
  int _selectedType;
  int _selectedDistrictId;
  int _selectedCadesterDistrictId;
  //Commented for testing
  // DateTime _startDate = DateTime(DateTime.now().year, DateTime.now().month);
  // DateTime _endDate = DateTime.now();
  DateTime _startDate = DateTime.parse('2020-01-01');
  DateTime _endDate = DateTime.parse('2020-01-10');

  final GetDistrictsUseCase _getDistrictsUseCase;
  final GetCadesterDistrictsUseCase _getCadesterDistrictsUseCase;

  List<District> districts = List<District>();
  List<CadesterDistrict> cadesterDistricts = List<CadesterDistrict>();

  TextEditingController _startDateController;
  TextEditingController _endDateController;
  TextEditingController _maxPriceController;
  TextEditingController _minPriceController;
  TextEditingController _maxSizeController;
  TextEditingController _minSizeController;

  TextEditingController get startDateController => _startDateController;
  TextEditingController get endDateController => _endDateController;
  TextEditingController get maxPriceController => _maxPriceController;
  TextEditingController get minPriceController => _minPriceController;
  TextEditingController get maxSizeController => _maxSizeController;
  TextEditingController get minSizeController => _minSizeController;

  bool _expanded = false;

  bool get expanded => _expanded;
  set expanded(bool value) {
    _expanded = value;
    forceNotify();
  }

  SidebarViewModel(
      this._getDistrictsUseCase, this._getCadesterDistrictsUseCase);

  DateTime get startDate => _startDate;
  set startDate(DateTime value) {
    _startDate = value;
    startDateController.text = PPDateTime.toEuroString(value);
    forceNotify();
  }

  DateTime get endDate => _endDate;
  set endDate(DateTime value) {
    _endDate = value;
    endDateController.text = PPDateTime.toEuroString(value);
    forceNotify();
  }

  void init() async {
    _startDateController =
        TextEditingController(text: PPDateTime.toEuroString(startDate));
    _endDateController =
        TextEditingController(text: PPDateTime.toEuroString(endDate));
    _maxPriceController = TextEditingController();
    _minPriceController = TextEditingController();
    _maxSizeController = TextEditingController();
    _minSizeController = TextEditingController();

    await getDistricts();
  }

  set selectedCategory(int id) {
    _selectedCategory = id;
    notifyListeners();
  }

  int get selectedCategory => _selectedCategory;
  set selectedType(int id) {
    _selectedType = id;
    notifyListeners();
  }

  int get selectedType => _selectedType;

  int get selectedDistrictId => _selectedDistrictId;
  set selectedDistrictId(int value) {
    _selectedDistrictId = value;
    notifyListeners();
  }

  int get selectedCadesterDistrictId => _selectedCadesterDistrictId;
  set selectedCadesterDistrictId(int value) {
    _selectedCadesterDistrictId = value;
    forceNotify();
  }

  GetContractsRequest createFilters() {
    GetContractsRequest request = GetContractsRequest(
      propertyTypeId: selectedType,
      dateFilter: DateFilter(
        min: startDate,
        max: endDate,
      ),
    );
    if (minPriceController.text.isNotEmpty ||
        maxPriceController.text.isNotEmpty) {
      PriceFilter priceFilter = PriceFilter(
          min: minPriceController.text.isNotEmpty
              ? int.parse(minPriceController.text)
              : null,
          max: maxPriceController.text.isNotEmpty
              ? int.parse(
                  maxPriceController.text,
                )
              : null);
      request.priceFilter = priceFilter;
    }
    if (minSizeController.text.isNotEmpty ||
        maxSizeController.text.isNotEmpty) {
      SizeFilter sizeFilter = SizeFilter(
          min: minSizeController.text.isNotEmpty
              ? int.parse(minSizeController.text)
              : null,
          max: maxSizeController.text.isNotEmpty
              ? int.parse(
                  maxSizeController.text,
                )
              : null);
      request.sizeFilter = sizeFilter;
    }
    return request;
  }

  Future<bool> getDistricts() async {
    DataResult result = await load(_getDistrictsUseCase.getDistricts());
    if (!result.isFailure()) {
      districts = result.data;
      forceNotify();
      return true;
    } else {
      error = 'Error while getting districts.';
      return false;
    }
  }

  Future<bool> getCadesterDistrict(int districtId) async {
    DataResult result = await load(_getCadesterDistrictsUseCase
        .getCadesterDistricts(districts[districtId].name));
    if (!result.isFailure()) {
      cadesterDistricts = result.data;
      forceNotify();
      return true;
    } else {
      error = 'Error while getting cadester districts.';
      return false;
    }
  }
}
