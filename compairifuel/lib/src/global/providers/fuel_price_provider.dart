import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/fuel_price.dart';
import '../typedefs.dart';
import 'api_provider.dart';
import 'fuel_option_provider.dart';
import 'gasstations_provider.dart';

final fuelPriceProvider =
    FutureProviderFamily<FuelPriceModel, String>((ref, id) async {
  final ApiService apiService = await ref.read(apiProvider.future);

  final gasstation =
      ref.read(gasStationNotifierProvider.notifier).getGasStationById(id);
  final fuelOption = ref.watch(fuelOptionProvider).name;

  final response = await apiService.get(
      "/prices/$fuelOption/${gasstation.position.latitude}/${gasstation.position.longitude}");
  return FuelPriceModel.fromJson(jsonDecode(response.body) as Json);
});
