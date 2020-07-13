import 'package:property_price_mob/ui/app/home/home_viewmodel.dart';
import 'package:property_price_mob/ui/app/home/pp_map/pp_map_viewmodel.dart';
import 'package:property_price_mob/ui/app/home/sidebar/sidebar_viewmodel.dart';
import 'package:property_price_mob/usecase/contract/get_contracts_use_case.dart';
import 'package:property_price_mob/usecase/property/get_property_types_use_case.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> independentProviders = [
  Provider<GetPropertyTypesUseCase>.value(value: GetPropertyTypesUseCase()),
  Provider<GetContractsUseCase>.value(value: GetContractsUseCase()),
];

List<SingleChildWidget> dependentProviders = [
  ChangeNotifierProxyProvider2<GetContractsUseCase, GetPropertyTypesUseCase,
      HomeViewModel>(
    create: (context) =>
        HomeViewModel(GetContractsUseCase(), GetPropertyTypesUseCase()),
    update: (_, getContractsUseCase, getPropertyTypesUseCase, instance) =>
        instance,
  ),
  ChangeNotifierProxyProvider<GetContractsUseCase, PPMapViewModel>(
    create: (context) => PPMapViewModel(),
    update: (_, getContractsUseCase, instance) => instance,
  ),
  ChangeNotifierProxyProvider<GetContractsUseCase, SidebarViewModel>(
    create: (context) => SidebarViewModel(),
    update: (_, getContractsUseCase, instance) => instance,
  ),
];
