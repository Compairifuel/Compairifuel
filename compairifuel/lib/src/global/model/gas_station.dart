import 'package:compairifuel/src/global/model/position.dart';
import 'package:compairifuel/src/global/typedefs.dart';

class GasStationModel {
  late final PositionModel position;
  late final String name;
  late final String id;
  late final String address;
  late final List<PositionModel> entryPoints;
  late final List<PositionModel> viewport;

  GasStationModel(
      {required this.position,
      required this.name,
      required this.id,
      required this.address,
      required this.entryPoints,
      required this.viewport});

  factory GasStationModel.fromJson(Json json) {
    return GasStationModel(
        position: PositionModel.fromJson(json["position"]),
        name: json["name"],
        id: json["id"],
        address: json["address"],
        entryPoints: List.of(json["entryPoints"])
            .map((e) => PositionModel.fromJson(e))
            .toList(),
        viewport: List.of(json["viewport"])
            .map((e) => PositionModel.fromJson(e))
            .toList());
  }

  Json toJson() {
    Json data = {
      "position": position.toJson(),
      "name": name,
      "id": id,
      "address": address,
      "entryPoints": entryPoints.map((e) => e.toJson()),
      "viewport": viewport.map((e) => e.toJson())
    };
    return data;
  }

  @override
  bool operator ==(Object other) {
    return other is GasStationModel &&
        other.position == position &&
        other.name == name &&
        other.id == id &&
        other.address == address &&
        other.entryPoints == entryPoints &&
        other.viewport == viewport;
  }

  @override
  int get hashCode => position.hashCode ^ name.hashCode ^ id.hashCode ^ address.hashCode ^ entryPoints.hashCode ^ viewport.hashCode;
}
