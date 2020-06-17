import 'package:property_price_mob/usecase/district/get_districts_use_case.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> independentProviders = [
  Provider<GetDistrictsUseCase>.value(value: GetDistrictsUseCase())
];

List<SingleChildWidget> dependentProviders = [
  ChangeNotifierProxyProvider<GetDistrictsUseCase, SidebarViewModel>(
      create: (context) => SidebarViewModel(GetDistrictsUseCase()),
      update: (_, getDistrictUseCase, instance) => instance),
];
