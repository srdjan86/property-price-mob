import 'package:flutter/material.dart';
import 'package:property_price_mob/model/contract.dart';
import 'package:property_price_mob/model/pp_marker.dart';
import 'package:property_price_mob/ui/base/base_viewmodel.dart';
import 'package:property_price_mob/usecase/contract/get_contracts_use_case.dart';
import 'package:latlong/latlong.dart';

class HomeViewModel extends BaseViewModel {
  final GetContractsUseCase _getContractsUseCase;

  HomeViewModel(this._getContractsUseCase);

  List<Contract> contracts = List<Contract>();
  List<PPMarker> markers = List<PPMarker>();

  void getContracts(DateTime startDate, DateTime endDate) async {
    final result = await _getContractsUseCase.getContracts(startDate, endDate);
    if (!result.isFailure()) {
      contracts = result.data;
      createLocations();
      forceNotify();
    }
  }

  void createLocations() {
    Map<String, PPMarker> map = new Map();
    for (var contract in contracts) {
      for (var property in contract.properties) {
        final key = property.location.lat.toString() +
            '-' +
            property.location.lon.toString();
        if (map[key] == null) {
          map[key] = PPMarker(
            contracts: [contract],
            point: LatLng(property.location.lat, property.location.lon),
            builder: (ctx) => Image.asset(
              'assets/images/residence-512.png',
              height: 10,
              width: 10,
            ),
          );
        } else {
          if ((map[key].contracts.singleWhere((c) => c.id == contract.id,
                  orElse: () => null)) !=
              null) {
          } else {
            map[key].contracts.add(contract);
          }
        }
      }
    }
    map.forEach((k, v) => markers.add(v));
    forceNotify();
  }

  @override
  void init() {}
}
