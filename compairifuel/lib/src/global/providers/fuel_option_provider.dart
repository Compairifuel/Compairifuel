import 'package:flutter_riverpod/flutter_riverpod.dart';

final fuelOptionProvider = NotifierProvider<FuelOptionNotifier, FuelOption>(
    () => FuelOptionNotifier());

class FuelOptionNotifier extends Notifier<FuelOption> {
  @override
  FuelOption build() => FuelOption.euro95;

  void selectDiesel() => state = FuelOption.diesel;

  void selectEuro95() => state = FuelOption.euro95;

  setFuelOption(FuelOption fuelOption) => state = fuelOption;
}

enum FuelOption {
  diesel("Diesel"),
  euro95("Euro95");

  const FuelOption(this.name);

  final String name;
}
