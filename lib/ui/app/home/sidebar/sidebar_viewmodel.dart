import 'package:property_price_mob/model/district.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:property_price_mob/usecase/district/get_districts_use_case.dart';

class SidebarViewModel extends BaseViewModel {
  final GetDistrictsUseCase getDistrictsUseCase;
  List<District> districts = new List<District>();
  List<District> cadasterDistricts = new List<District>();
  String selectedDistrict;
  String selectedCadesterDistrict;

  SidebarViewModel(this.getDistrictsUseCase);

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
