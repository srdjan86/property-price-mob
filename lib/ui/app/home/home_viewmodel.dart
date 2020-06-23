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
  Map<String, PPMarker> markersMap = new Map();
  List<PPMarker> markers = List<PPMarker>();

  String _selectedMarkerId;

  String get selectedMarkerId => _selectedMarkerId;
  set selectedMarkerId(String value) {
    _selectedMarkerId = value;
    forceNotify();
  }

  void getContracts(DateTime startDate, DateTime endDate) async {
    final result = await _getContractsUseCase.getContracts(startDate, endDate);
    if (!result.isFailure()) {
      contracts = result.data;
      createLocations();
      forceNotify();
    }
  }

  void createLocations() {
    markersMap = new Map();
    for (var contract in contracts) {
      for (var property in contract.properties) {
        final key = property.location.lat.toString() +
            '-' +
            property.location.lon.toString();
        if (markersMap[key] == null) {
          markersMap[key] = PPMarker(
            id: key,
            contracts: [contract],
            point: LatLng(property.location.lat, property.location.lon),
            onTap: () {
              selectedMarkerId = key;
              forceNotify();
            },
          );
        } else {
          if ((markersMap[key].contracts.singleWhere((c) => c.id == contract.id,
                  orElse: () => null)) !=
              null) {
          } else {
            markersMap[key].contracts.add(contract);
          }
        }
      }
    }
    markersMap.forEach((k, v) => markers.add(v));
    forceNotify();
  }

  @override
  void init() {}
}
