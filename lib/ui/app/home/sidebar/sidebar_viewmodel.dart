import 'package:property_price_mob/model/district.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:property_price_mob/usecase/district/get_districts_use_case.dart';

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
    // TODO: implement init
    districts = await load(getDistrictsUseCase.getAllDistricts());
  }

  setSelectedDistrict(String districtValue) {
    selectedDistrict = districtValue;
    notifyListeners();
  }

  setSelectedCadesterDistrict(String districtValue) {
    selectedCadesterDistrict = districtValue;
    notifyListeners();
  }
}
