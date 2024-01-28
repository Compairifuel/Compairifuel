import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FuelMarkerLayer extends StatelessWidget {
  // final Function onTap;
  final List<Map<String,dynamic>>? gasStationList;

  const FuelMarkerLayer(
      {super.key,
      // required this.onTap,
      this.gasStationList});

  @override
  Widget build(BuildContext context) {
    // debugPrint(gasStationList.toString());

    return MarkerLayer(
      markers: [

        ...?gasStationList?.map(
          (e) => Marker(
            width: 40.0,
            height: 40.0,
            point: e["position"],
            child: GestureDetector(
              onTap: () {
                e["onTap"]();
              },
              child: const ImageIcon(
                AssetImage("assets/images/gas_station-kopie.png"),
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
