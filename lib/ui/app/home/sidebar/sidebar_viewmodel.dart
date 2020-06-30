import 'package:flutter/material.dart';
import 'package:property_price_mob/model/district.dart';
import 'package:property_price_mob/model/get_contracts_request.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:property_price_mob/usecase/district/get_districts_use_case.dart';
import 'package:property_price_mob/utils/pp_datetime.dart';

class SidebarViewModel extends BaseViewModel {
  final GetDistrictsUseCase getDistrictsUseCase;
  List<District> districts = new List<District>();
  List<District> cadasterDistricts = new List<District>();
  String selectedDistrict;
  String selectedCadesterDistrict;
  //Commented for testing
  // DateTime _startDate = DateTime(DateTime.now().year, DateTime.now().month);
  // DateTime _endDate = DateTime.now();
  DateTime _startDate = DateTime.parse('2020-01-01');
  DateTime _endDate = DateTime.parse('2020-01-10');

  TextEditingController _startDateController;
  TextEditingController _endDateController;
  TextEditingController _maxPriceController;
  TextEditingController _minPriceController;

  TextEditingController get startDateController => _startDateController;
  TextEditingController get endDateController => _endDateController;
  TextEditingController get maxPriceController => _maxPriceController;
  TextEditingController get minPriceController => _minPriceController;

  SidebarViewModel(this.getDistrictsUseCase);

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
    districts = await load(getDistrictsUseCase.getAllDistricts());
    _startDateController =
        TextEditingController(text: PPDateTime.toEuroString(startDate));
    _endDateController =
        TextEditingController(text: PPDateTime.toEuroString(endDate));
    _maxPriceController = TextEditingController();
    _minPriceController = TextEditingController();
  }

  setSelectedDistrict(String districtValue) {
    selectedDistrict = districtValue;
    notifyListeners();
  }

  setSelectedCadesterDistrict(String districtValue) {
    selectedCadesterDistrict = districtValue;
    notifyListeners();
  }

  GetContractsRequest createFilters() {
    GetContractsRequest request = GetContractsRequest(
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
    return request;
  }
}
