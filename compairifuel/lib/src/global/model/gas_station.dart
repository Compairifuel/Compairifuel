import 'package:compairifuel/src/global/model/position.dart';
import 'package:compairifuel/src/global/typedefs.dart';
import 'package:equatable/equatable.dart';

class GasStationModel extends Equatable {
  final PositionModel position;
  final String name;
  final String id;
  final String address;
  final List<PositionModel> entryPoints;
  final List<PositionModel> viewport;

  const GasStationModel(
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
  List<Object?> get props =>
      [position, name, id, address, entryPoints, viewport];
}
