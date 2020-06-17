import 'package:property_price_mob/model/district.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:property_price_mob/usecase/district/get_districts_use_case.dart';

class SidebarViewModel extends BaseViewModel {
  final GetDistrictsUseCase getDistrictsUseCase;
  List<District> districts = new List<District>();
  List<District> cadasterDistricts = new List<District>();
  String selectedDistrict;
  String selectedCadesterDistrict;
  DateTime _startDate = DateTime(DateTime.now().year, DateTime.now().month);
  DateTime _endDate = DateTime.now();

  SidebarViewModel(this.getDistrictsUseCase);

  DateTime get startDate => _startDate;
  set startDate(DateTime value) {
    _startDate = value;
    forceNotify();
  }

  DateTime get endDate => _endDate;
  set endDate(DateTime value) {
    _endDate = value;
    forceNotify();
  }

  @override
  void init() async {
    print('selected district $selectedDistrict');
    // TODO: implement init
    districts = await load(getDistrictsUseCase.getAllDistricts());
  }

  setSelectedDistrict(String districtValue) {
    print('districtValue $districtValue');
    selectedDistrict = districtValue;
    notifyListeners();
  }

  setSelectedCadesterDistrict(String districtValue) {
    selectedCadesterDistrict = districtValue;
    notifyListeners();
  }
}
