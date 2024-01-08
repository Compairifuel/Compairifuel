import 'dart:core';
import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:async';
import '../TomTomApi.dart' as TomTomApi;

Future d() async {
  await Future.delayed(Duration(seconds: 2));
}


Future main() async {
  await dotenv.load(fileName: ".env");
}

// void startListeningLocationUpdates() {
//   Geolocator.getPositionStream().listen((Position position) {
//   });
// }

Future<dynamic> searchNearby(double latitude, double longitude, {int radius = 50000}) async {
  String apiKey = dotenv.get("apiKey");
  final apiUrl =
      'https://api.tomtom.com/search/2/nearbySearch/.json?key=$apiKey&lat=$latitude&lon=$longitude&radius=$radius&categorySet=7311';

  try {
    debugPrint('TomTom API URL: $apiUrl');
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final results = response.body;
      // final results = await json.encoder.convert(response.body);
      // debugPrint('TomTom API Results: $results');
      // print(results);
      //
      // await json.decode(results);
      return results;
    } else {
      debugPrint('Failed to fetch data from TomTom API. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error making request to TomTom API: $e');
  }
  return {};
}

class LocationService {
  final Geolocator _geolocator = Geolocator();
  late StreamSubscription<Position>? _locationSubscription;

  Future<void> checkLocationAndSendNotification() async {
    bool isLocationEnabled = await _isLocationServiceEnabled();

    if (!isLocationEnabled) {
      // Handle the case where location is not enabled
      // You might want to show a message to the user or take appropriate action
      throw Exception("Location is not enabled");
    }
  }

  Future<bool> _isLocationServiceEnabled() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void startListeningLocationUpdates(void Function(Position) onLocationUpdate) {
    _locationSubscription =
        Geolocator.getPositionStream().listen(onLocationUpdate);
  }

  void dispose() {
      _locationSubscription!.cancel();
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
  LatLng? _userLocation = LatLng(51.3, 5.1);
  final MapController _mapController = MapController();
  List<Marker>? nearbyPoiMarkers;

  // show gasstation markers on the map

  // every 30 seconds execute the searchNearby function and update the list of gasstations

  @override
  void initState() {
    super.initState();

    // Check if location services are enabled
    _locationService.checkLocationAndSendNotification().catchError((error) {
      // Handle the error if location services are not enabled
      print("Location Services Error: $error");
    });

    // Start listening for location updates
    _locationService.startListeningLocationUpdates((Position position) {
      print("Location updated: ${position.latitude}, ${position.longitude}");
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);

        if (_userLocation != null) {
          // Your map-related code
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

    fetchNearbyPoiMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _userLocation!,
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
                ...?nearbyPoiMarkers,
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

  @override
  void dispose() {
    // Cleanup tasks go here
    // For example, you might dispose of controllers or close streams
    _locationService.dispose();

    super.dispose();
  }

  void fetchNearbyPoiMarkers() async {
    try {
      final result = await searchNearby(51.9886174, 5.4989983);
      final decodedResult = jsonDecode(result) as Map<String, dynamic>;
      final autogenResult = TomTomApi.Autogenerated.fromJson(decodedResult);

      setState(() {
        nearbyPoiMarkers = autogenResult.results!.map((e) =>
            Marker(
              point: LatLng(e.position!.lat as double, e.position!.lon as double),
              child: GestureDetector(
                onTap: () {
                  debugPrint("${e.poi?.name} tapped");
                },
                child: const ImageIcon(
                  AssetImage("assets/images/location.png"),
                  size: 24,
                ),
              ),
            )).toList();

        // Now you can use nearbyPoiMarkers where needed.
      });
    } catch (error) {
      // Handle any errors that might occur during the asynchronous operations
      debugPrint("Error fetching nearby POI markers: $error");
    }
  }
}