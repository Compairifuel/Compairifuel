enum FuelOption {
  diesel("Diesel"),
  lpg("Lpg"),
  eur90("Eur90"),
  eur98("Eur98");

  const FuelOption({
    required this.name
  })

  final String name;

  String get name => name
}