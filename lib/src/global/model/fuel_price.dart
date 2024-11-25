import 'package:compairifuel/src/global/model/position.dart';
import 'package:equatable/equatable.dart';

class FuelPriceModel extends Equatable {
  final PositionModel position;
  final String address;
  final double price;

  const FuelPriceModel({
    required this.position,
    required this.address,
    required this.price,
  });

  factory FuelPriceModel.fromJson(Map<String, dynamic> json) {
    return FuelPriceModel(
      position: PositionModel.fromJson(json["position"]),
      address: json["address"],
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "position": position.toJson(),
      "address": address,
      "price": price,
    };
  }

  @override
  List<Object?> get props => [position, address, price];
}
