import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

Future main() async {
  await dotenv.load(fileName: ".env");

  searchNearby(51.9886174,5.4989983).then((res)=>jsonDecode(res)["results"]).then((res)=>{
              for(var i in res){
                print(assert(i is _JsonMap))
                print(i is String)

                print(i["poi"]["name"] +" "+ i["position"]+"\n")
  }
  });
}

void startListeningLocationUpdates() {
  Geolocator.getPositionStream().listen((Position position) {
  });
}

Future<String> searchNearby(double latitude, double longitude, {int radius = 50000}) async {
  String apiKey = dotenv.get("apiKey");
  final apiUrl =
      'https://api.tomtom.com/search/2/nearbySearch/.json?key=$apiKey&lat=$latitude&lon=$longitude&radius=$radius&categorySet=7311';

  try {
    debugPrint('TomTom API URL: $apiUrl');
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final results = response.body;
      // debugPrint('TomTom API Results: $results');
      return results;
    } else {
      debugPrint('Failed to fetch data from TomTom API. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error making request to TomTom API: $e');
  }
  return '';
}

class LocationService {
  final Geolocator _geolocator = Geolocator();

  Future<void> checkLocationAndSendNotification() async {
    bool isLocationEnabled = await _isLocationServiceEnabled();

    if (!isLocationEnabled) {
      Future.error("Location is not enabled");
    }
  }

  Future<bool> _isLocationServiceEnabled() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Stream<Position> startListeningLocationUpdates() {
    return Geolocator.getPositionStream();
  }

}

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  // get location of gasstations by using the TomTom API function searchNearby
  // then get only the gasstations out of the results
  // then make a list of the gasstations and use the map function to make a marker for each gasstation.


  // every 30 seconds execute the searchNearby function and update the list of gasstations

  // searchNearby(_userLocation!.latitude, _userLocation!.longitude).then((res)=>{print(res)});

  @override
  void didUpdateWidget(covariant MapPage widget) async {
    super.didUpdateWidget(widget);

    print("didUpdateWidget");

    // String res = await searchNearby(_userLocation!.latitude, _userLocation!.longitude);
    // print(res);
  }

  final LocationService _locationService = LocationService();
  Position? _currentPosition;
  late LatLng? _userLocation = const LatLng(0, 0);
  final MapController _mapController = MapController();
  // late CameraFit _cameraFit = CameraConstraint.containCenter(bounds: LatLngBounds(_userLocation!,_userLocation!);

  @override
  void initState() {
    super.initState();
    debugPrint(_locationService.startListeningLocationUpdates().toString());
    if(_locationService.startListeningLocationUpdates().toString() == "Instance of 'Stream<Position>'") {
      _locationService.startListeningLocationUpdates();
    } else {
      _locationService.getCurrentLocation().then((Position position) {
        setState(() {
          _userLocation = LatLng(position.latitude, position.longitude);
        });
      });
    }
    _locationService.startListeningLocationUpdates().listen((Position position) {
      setState(() {
        // _userLocation = LatLng(244, 9999);
        _userLocation = LatLng(position.latitude, position.longitude);

        if(_userLocation != null) {
          final cameraFit = CameraFit.bounds(
            bounds: LatLngBounds(_userLocation!,_userLocation!),
            padding: const EdgeInsets.all(8.0),
          );

          cameraFit.fit(_mapController.camera);
          _mapController.fitCamera(cameraFit);
          _mapController.move(_userLocation!, 0.0);
        }
      });
    });
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _userLocation!,
            // initialCameraFit: CameraFit.bounds(
            //   bounds: _mapController.camera.visibleBounds,
            // ),
            // initialZoom: 0.0,
            // onMapReady: () {
            //   _mapController.move(
            //   _userLocation!,
            //       0.0,
            //   );
            // },
            // interactionOptions: InteractionOptions(
            //   flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            // ),
            // initialCameraFit: CameraFit,
            // initialCenter: _userLocation ?? const LatLng(0, 0),

            // cameraConstraint: CameraConstraint.containCenter(bounds: LatLngBounds(_userLocation!,_userLocation!),
            // ),


            // CameraFit.bounds(
            //   bounds: LatLngBounds(_userLocation!,_userLocation!),
            //   padding: const EdgeInsets.all(8.0),
            // ),

          ),
          children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                //https://{baseURL}/map/{versionNumber}/tile/{layer}/{style}/{zoom}/{X}/{Y}.{format}?key={Your_API_Key}
                // tileBounds: LatLngBounds(_userLocation!,_userLocation!),
                //useragend: hebben we m nog nodig?
              ),
            MarkerLayer(
              markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: _userLocation!,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint("Marker tapped");
                      },
                      child: const ImageIcon(
                        AssetImage("assets/images/location.png"),
                        size: 24,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}