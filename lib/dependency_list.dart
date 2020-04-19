import 'package:property_price_mob/usecase/district/get_districts_use_case.dart';
import 'package:provider/provider.dart';

final independentProviders = [Provider.value(value: GetDistrictsUseCase())];
