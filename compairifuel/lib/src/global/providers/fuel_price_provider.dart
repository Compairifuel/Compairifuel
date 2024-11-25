import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/fuel_price.dart';
import '../typedefs.dart';
import 'api_provider.dart';
import 'fuel_option_provider.dart';
import 'gasstations_provider.dart';

final fuelPriceProvider =
    FutureProviderFamily<FuelPriceModel, String>((ref, id) async {
  final ApiService apiService = await ref.watch(apiProvider.future);

  final gasstation =
      ref.watch(gasStationNotifierProvider.notifier).getGasStationById(id);
  final fuelOption = ref.watch(fuelOptionProvider).name;

  final response = await apiService.get(
      "/prices/$fuelOption/${gasstation!.position.latitude}/${gasstation.position.longitude}");
  return (jsonDecode(response.body) as List<dynamic>)
      .cast<Json>()
      .map((el) => FuelPriceModel.fromJson(el))
      .toList()
      .first;
});
