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
                e["onTap"](
                  checkNull(e),
                  showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                    title: Text(e["name"]),
                    content: Text('€${e["price"]?.toStringAsFixed(2)}/L van de gekozen brandstof'),

                  actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                )
                  )
                );
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
void checkNull(Map<String, dynamic> e) {
  if (e["price"] == null) {
    e["price"] = 0.00;
  }
}
