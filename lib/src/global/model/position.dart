import 'package:latlong2/latlong.dart';
import 'package:compairifuel/src/global/typedefs.dart';

class PositionModel {
  late final double latitude;
  late final double longitude;

  PositionModel({required this.latitude, required this.longitude});

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
}
