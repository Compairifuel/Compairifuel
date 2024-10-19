import 'package:latlong2/latlong.dart';
import 'package:compairifuel/src/global/typedefs.dart';
import 'package:equatable/equatable.dart';

class PositionModel extends Equatable {
  final double latitude;
  final double longitude;

  const PositionModel({required this.latitude, required this.longitude});

  factory PositionModel.fromJson(Json json) {
    return PositionModel(
        latitude: json["latitude"], longitude: json["longitude"]);
  }

  Json toJson() {
    Json data = {"latitude": latitude, "longitude": longitude};
    return data;
  }

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }

  @override
  List<Object?> get props => [latitude, longitude];
}
