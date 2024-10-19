import 'package:compairifuel/src/global/model/gas_station.dart';
import 'package:compairifuel/src/global/model/position.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("GasStationModel", () {
    test("should return a json of the GasStationModel", () {
      var sut = const GasStationModel(
          position: PositionModel(latitude: 56.00, longitude: 5.00),
          name: 'Tankstation Remmerden',
          id: '123456abc',
          address: 'Remmerden 1',
          entryPoints: [
            PositionModel(latitude: 56.00, longitude: 5.00),
            PositionModel(latitude: 56.00, longitude: 5.00)
          ],
          viewport: [
            PositionModel(latitude: 56.00, longitude: 5.00),
            PositionModel(latitude: 56.00, longitude: 5.00)
          ]);
      var expected = {
        "position": {"latitude": 56.00, "longitude": 5.00},
        "name": "Tankstation Remmerden",
        "id": "123456abc",
        "address": "Remmerden 1",
        "entryPoints": [
          {"latitude": 56.00, "longitude": 5.00},
          {"latitude": 56.00, "longitude": 5.00}
        ],
        "viewport": [
          {"latitude": 56.00, "longitude": 5.00},
          {"latitude": 56.00, "longitude": 5.00}
        ]
      };

      var result = sut.toJson();

      expect(result, equals(expected));
    });
  });
}
