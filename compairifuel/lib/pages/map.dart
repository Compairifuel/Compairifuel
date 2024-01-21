import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:async';
import '../TomTomApiSearch.dart' as TomTomApiSearch;
import '../TomTomApiFuelPrice.dart' as TomTomApiFuelPrice;

Future main() async {
  await dotenv.load(fileName: ".env");
}

Future<dynamic> searchNearby(double latitude, double longitude,
    {int radius = 50000}) async {
  String apiKey = dotenv.get("apiKey");

  // Electric vehicle charging stations == 7309
  // Gas stations == 7311

  final apiUrl =
      'https://api.tomtom.com/search/2/nearbySearch/.json?key=$apiKey&lat=$latitude&lon=$longitude&radius=$radius&categorySet=7311&relatedPois=all&limit=100&countrySet=NLD,BEL,DEU&minFuzzyLevel=1&maxFuzzyLevel=4';
  try {
    debugPrint('TomTom API URL: $apiUrl');
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final results = response.body;
      return results;
    } else {
      debugPrint(
          'Failed to fetch data from TomTom API. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error making request to TomTom API: $e');
  }
  return "{}";
}

Future<dynamic> poiSearch(
  String? query,
  double latitude,
  double longitude,
) async {
  String apiKey = dotenv.get("apiKey");
  final apiUrl =
      'https://api.tomtom.com/search/2/poiSearch/$query.json?key=$apiKey&lat=$latitude&lon=$longitude&categorySet=7311&relatedPois=all';
  try {
    debugPrint('TomTom API URL: $apiUrl');
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final results = response.body;
      return results;
    } else {
      debugPrint(
          'Failed to fetch data from TomTom API. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error making request to TomTom API: $e');
  }
  return "{}";
}

Future<dynamic> fuelPrices(String fuelPrice) async {
  String apiKey = dotenv.get("apiKey");
  fuelPrice = "1:cf81fe50-6218-11ea-a677-d05099d5f839";
  final apiUrl =
      'https://api.tomtom.com/search/2/fuelPrice.json?key=$apiKey&fuelPrice=$fuelPrice';
  try {
    debugPrint('TomTom API URL: $apiUrl');
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final results = response.body;
      return results;
    } else {
      debugPrint(
          'Failed to fetch data from TomTom API. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error making request to TomTom API: $e');
  }
  return "{}";
}

class LocationService {
  late StreamSubscription<Position>? _locationSubscription;
  late bool isLocationEnabled;

  Future<void> checkLocationAndSendNotification() async {
    isLocationEnabled = await _isLocationServiceEnabled();

    if (!isLocationEnabled) {
      // Handle the case where location is not enabled
      // You might want to show a message to the user or take appropriate action
      Geolocator.requestPermission();
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
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
  }

  void startListeningLocationUpdates(void Function(Position) onLocationUpdate) {
    _locationSubscription =
        Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation,distanceFilter: 10, timeLimit: Duration(milliseconds: 500))).listen(onLocationUpdate);
  }

  void dispose() {
    _locationSubscription!.cancel();
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.title});

  final String title;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LocationService _locationService = LocationService();
  LatLng? _userLocation = const LatLng(51.98, 5.4);
  final MapController _mapController = MapController();
  List<Marker> nearbyPoiMarkers = [];
  Map<String, dynamic> poi = {};

  // show gas station markers on the map

  // every 30 seconds execute the searchNearby function and update the list of gas stations

  @override
  void initState() {
    super.initState();

    // Check if location services are enabled
    _locationService.checkLocationAndSendNotification().catchError((error) {
      // Handle the error if location services are not enabled
      debugPrint("Location Services Error: $error");
    });

    // Start listening for location updates
    _locationService.startListeningLocationUpdates((Position position) {
      // is the location different from the previous location?
      if(_userLocation == LatLng(position.latitude, position.longitude)) {
        return;
      } else {
        debugPrintSynchronously(
            "Location updated: ${position.latitude}, ${position.longitude} previous location: ${_userLocation!.latitude}, ${_userLocation!.longitude}", wrapWidth: 1000);

        fetchNearbyPoiMarkers(position.latitude, position.longitude);

        setState(() {
          try {
            _userLocation = LatLng(position.latitude, position.longitude);
          } catch (e) {
            debugPrint("Error updating location: $e");
          }
        });

        try {
          // FIXME
          // if (_userLocation != null) {
          //   // Your map-related code
          //   final cameraFit = CameraFit.bounds(
          //     bounds: LatLngBounds(_userLocation!, _userLocation!),
          //     padding: const EdgeInsets.all(8.0),
          //   );
          //
          //   cameraFit.fit(_mapController.camera);
          //   _mapController.fitCamera(cameraFit);
          //   _mapController.move(_userLocation!, 0.0);
          // }
        } catch (e) {
          debugPrint("Error moving camera: $e");
        }
      }
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
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              //https://{baseURL}/map/{versionNumber}/tile/{layer}/{style}/{zoom}/{X}/{Y}.{format}?key={Your_API_Key}
              // tileBounds: LatLngBounds(_userLocation!,_userLocation!),
              //useragend: hebben we m nog nodig?
            ),
            MarkerLayer(
              markers: [
                ...nearbyPoiMarkers,
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
  void didUpdateWidget(MapPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("MapPage didUpdateWidget");
    // fetchNearbyPoiMarkers(_userLocation!.latitude, _userLocation!.longitude);
  }

  @override
  void dispose() {
    // Cleanup tasks go here
    // For example, you might dispose of controllers or close streams
    _locationService.dispose();

    super.dispose();
  }

  Future<void> fetchNearbyPoiMarkers(latitude, longitude) async {
    try {
      var result = await searchNearby(latitude, longitude);
      var decodedResult = jsonDecode(result) as Map<String, dynamic>;
      var autogenResult = TomTomApiSearch.Autogenerated.fromJson(decodedResult);

      debugPrintSynchronously(autogenResult.results?.take(3).map((e) => e.toJson()).toList().toString());

      // for (var element in autogenResult.results!) {
      //   if(element.dataSources?.fuelPrice?.id != null) {
      //     fetchFuelPrices(element.dataSources?.fuelPrice?.id! as String);
      //   }
      // }

      setState(() {
        nearbyPoiMarkers = autogenResult.results!
            .map((e) => Marker(
                  point: LatLng(
                      e.position!.lat as double, e.position!.lon as double),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint("${e.poi?.name} tapped");
                      debugPrint("${e.dataSources?.toJson()}");
                      if (e.dataSources?.fuelPrice?.id != null) {
                        fetchFuelPrices(
                            e.dataSources?.fuelPrice?.id! as String);
                        debugPrint(
                            "${e.dataSources?.fuelPrice?.id} ${poi[e.dataSources?.fuelPrice?.id].toString()}");
                      }
                    },
                    child: const ImageIcon(
                      AssetImage("assets/images/gas_station-kopie.png"),
                      size: 24,
                    ),
                  ),
                ))
            .toList();

        // Now you can use nearbyPoiMarkers where needed.
      });
    } catch (error) {
      // Handle any errors that might occur during the asynchronous operations
      debugPrintSynchronously("Error fetching nearby POI markers: $error");
    }
  }

  Future<void> fetchFuelPrices(String fuelPriceId) async {
    try {
      var result = await fuelPrices(fuelPriceId);
      var decodedResult = jsonDecode(result) as Map<String, dynamic>;
      var autogenResult =
          TomTomApiFuelPrice.Autogenerated.fromJson(decodedResult);

      setState(() {
        poi[fuelPriceId] = autogenResult.fuels;
      });
    } catch (error) {
      // Handle any errors that might occur during the asynchronous operations
      debugPrintSynchronously("Error fetching nearby Fuelprices: $error");
    }
  }
}
