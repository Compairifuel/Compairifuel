enum FuelOption {
  diesel("Diesel"),
  lpg("Lpg"),
  eur90("Eur90"),
  eur98("Eur98");

  const FuelOption(String name) : _name = name;

  final String _name;

  String get getName => _name;
}