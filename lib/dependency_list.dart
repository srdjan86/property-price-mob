import 'package:property_price_mob/usecase/district/get_districts_use_case.dart';
import 'package:provider/provider.dart';

import 'ui/app/home/sidebar/sidebar_viewmodel.dart';
import 'ui/app/home/sidebar/sidebar_viewmodel.dart';
import 'usecase/district/get_districts_use_case.dart';

List<SingleChildCloneableWidget> independentProviders = [
  Provider.value(value: GetDistrictsUseCase())
];

List<SingleChildCloneableWidget> dependentProviders = [
  ChangeNotifierProxyProvider<GetDistrictsUseCase, SidebarViewModel>(
      create: (context) {
        print('create viewmodel');
        return SidebarViewModel(GetDistrictsUseCase());
      },
      update: (_, getDistrictUseCase, instance) => instance)
];
