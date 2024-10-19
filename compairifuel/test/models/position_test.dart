import 'package:compairifuel/src/global/model/position.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group("PositionModel", () {
    test("should return a PositionModel from the given json", () {
      var json = {"latitude": 56.00, "longitude": 5.00};
      var expected = const PositionModel(latitude: 56.00, longitude: 5.00);

      var result = PositionModel.fromJson(json);

      expect(result, equals(expected));
      expect(identical(result.hashCode, expected.hashCode), isTrue);
    });
    test("should return a json of the PositionModel", () {
      var sut = const PositionModel(latitude: 56.00, longitude: 5.00);
      var expected = {"latitude": 56.00, "longitude": 5.00};

      var result = sut.toJson();

      expect(result, equals(expected));
    });
    test("should return a LatLng of the PositionModel", () {
      var sut = const PositionModel(latitude: 56.00, longitude: 5.00);
      var expected = const LatLng(56.00, 5.00);

      var result = sut.toLatLng();

      expect(result, equals(expected));
      expect(identical(result.hashCode, expected.hashCode), isTrue);
    });
  });
}
