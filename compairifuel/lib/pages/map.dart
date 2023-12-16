import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void startListeningLocationUpdates() {
  Geolocator.getPositionStream().listen((Position position) {
  });
}

Future<void> searchNearby(double latitude, double longitude) async {
  const apiKey = 'TTkngWVhaw2tDzCPcd7EUMx7WAkY6I8x';
  final apiUrl =
      'https://api.tomtom.com/search/2/nearbySearch/.json?key=$apiKey&lat=$latitude&lon=$longitude&radius=50000';

  try {
    print('TomTom API URL: $apiUrl');
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final results = response.body;
      print('TomTom API Results: $results');
    } else {
      print('Failed to fetch data from TomTom API. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error making request to TomTom API: $e');
  }
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
  final LocationService _locationService = LocationService();
  Position? _currentPosition;
  late LatLng? _userLocation = LatLng(0, 0);
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
        _userLocation = LatLng(244, 9999);
        // _userLocation = LatLng(position.latitude, position.longitude);

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