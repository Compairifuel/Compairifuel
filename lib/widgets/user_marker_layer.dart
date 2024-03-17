// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
//
// class UserMarkerLayer extends StatelessWidget {
//   final LatLng userLocation;
//
//   const UserMarkerLayer({super.key, required this.userLocation});
//
//   @override
//   Widget build(BuildContext context) {
//     return MarkerLayer(
//       markers: [
//         Marker(
//           width: 40.0,
//           height: 40.0,
//           point: userLocation,
//           child: GestureDetector(
//             onTap: () {
//               debugPrint("Marker tapped");
//             },
//             child: const ImageIcon(
//               AssetImage("assets/images/location.png"),
//               size: 24,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
