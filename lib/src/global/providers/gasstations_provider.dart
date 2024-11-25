import 'dart:convert';

import 'package:compairifuel/src/global/extension/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:compairifuel/src/global/model/gas_station.dart';
import 'package:compairifuel/src/global/providers/api_provider.dart';
import 'package:compairifuel/src/global/providers/location_provider.dart';
import 'package:compairifuel/src/global/typedefs.dart';

final gasStationListProvider = FutureProvider((ref) async {
  ApiService apiService = await ref.read(apiProvider.future);
  final pos = ref.watch(mappedPositionProvider).valueOrNull;

  final response =
      await apiService.get("/gasStations/${pos?.latitude}/${pos?.longitude}");
  List<GasStationModel> list = (jsonDecode(response.body) as List<dynamic>)
      .cast<Json>()
      .map(GasStationModel.fromJson)
      .toList();

  ref.read(gasStationNotifierProvider.notifier).setGasStations(list);

  ref.cacheUntil(const Duration(hours: 1));
  return list;
});

final gasStationNotifierProvider =
    NotifierProvider<GasStationNotifier, List<GasStationModel?>>(
        () => GasStationNotifier());

class GasStationNotifier extends Notifier<List<GasStationModel?>> {
  @override
  List<GasStationModel?> build() => [];

  void setGasStations(List<GasStationModel?> gasstations) =>
      state = gasstations;

  GasStationModel? getGasStationById(String id) {
    return state.firstWhere((element) => element?.id == id);
  }
}
