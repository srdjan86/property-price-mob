import 'package:property_price_mob/ui/app/home/home_viewmodel.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_viewmodel.dart';
import 'package:property_price_mob/usecase/contract/get_contracts_use_case.dart';
import 'package:property_price_mob/usecase/district/get_districts_use_case.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> independentProviders = [
  Provider<GetDistrictsUseCase>.value(value: GetDistrictsUseCase()),
  Provider<GetContractsUseCase>.value(value: GetContractsUseCase()),
];

List<SingleChildWidget> dependentProviders = [
  ChangeNotifierProxyProvider<GetDistrictsUseCase, SidebarViewModel>(
    create: (context) => SidebarViewModel(GetDistrictsUseCase()),
    update: (_, getDistrictUseCase, instance) => instance,
  ),
  ChangeNotifierProxyProvider<GetContractsUseCase, HomeViewModel>(
    create: (context) => HomeViewModel(GetContractsUseCase()),
    update: (_, getContractsUseCase, instance) => instance,
  ),
  ChangeNotifierProxyProvider<GetContractsUseCase, PPMapViewModel>(
    create: (context) => PPMapViewModel(),
    update: (_, getContractsUseCase, instance) => instance,
  ),
];
