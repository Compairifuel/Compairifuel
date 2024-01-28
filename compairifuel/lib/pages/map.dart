import 'dart:core';

import 'package:compairifuel/widgets/user_marker_layer.dart';
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
import '../widgets/fuel_marker_layer.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
}

Future<dynamic> searchNearby(double latitude, double longitude,
    {int radius = 25000}) async {
  String apiKey = dotenv.get("apiKey");

  // Electric vehicle charging stations == 7309
  // Gas stations == 7311

  final apiUrl =
      'https://api.tomtom.com/search/2/nearbySearch/.json?key=$apiKey&lat=$latitude&lon=$longitude&radius=$radius&categorySet=7311&relatedPois=off&limit=100&countrySet=NLD,BEL,DEU&minFuzzyLevel=2&maxFuzzyLevel=4';
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

Future<dynamic> fuelPrices(String address) async {
  final apiUrl =
      'https://www.tankplanner.nl/api/v1/route/diesel/?origin=$address&destination=$address';
  try {
    debugPrint('Tankplanner API URL: ${Uri.parse(apiUrl)}');
    final response = await http.get(Uri.https("www.tankplanner.nl","/api/v1/route/diesel/",{"origin":address,"destination":address}), headers: {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      'Accept': '*/*',
    });
    if (response.statusCode == 200) {
      final results = response.body;
      return results;
    } else {
      debugPrint(
          'Failed to fetch data from Tankplanner API. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error making request to Tankplanner API: $e');
  }
  return jsonEncode([]);
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
  List<Map<String,dynamic>> nearbyPoiMarkers = [];
  Map<String, double> poiPrices = {};

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
    _locationService.startListeningLocationUpdates((Position position) async {
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
            ),
            UserMarkerLayer(userLocation: _userLocation!),
            FuelMarkerLayer(gasStationList: nearbyPoiMarkers),
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

      setState(() {
        nearbyPoiMarkers = autogenResult.results!.map((e) {
          Map<String,dynamic> a = <String,dynamic>{"position": LatLng(e.position?.lat ?? 0, e.position?.lon ?? 0),"name": e.poi?.name,"onTap": () {
            debugPrint("${e.poi?.name} tapped");
            var price = poiPrices[e.id];
            debugPrint(price.toString());
          },"address": e.address as dynamic,"id": e.id};
          return a;
        }).toList();
      });

      for (var e in autogenResult.results!){
        await getFuelPriceFromPoiAddress(e);
      }
    } catch (error, stacktrace) {
      // Handle any errors that might occur during the asynchronous operations
      debugPrintSynchronously("Error fetching nearby POI markers: $error $stacktrace");
    }
  }

  Future<dynamic> fetchFuelPrices(String address) async {
    try {
      var result = await fuelPrices(address);
      List<dynamic> decodedResult = jsonDecode(result) as List<dynamic>;
      return decodedResult;
    } catch (error) {
      // Handle any errors that might occur during the asynchronous operations
      debugPrintSynchronously("Error fetching nearby Fuelprices: $error");
    }
  }

  Future<void> getFuelPriceFromPoiAddress(TomTomApiSearch.Results element) async {
    List<dynamic> fuelprice = await fetchFuelPrices(
        '${element.address?.streetName}${element.address?.streetNumber != null
            ? (" ${element.address?.streetNumber ?? ""}")
            : ("")}, ${element.address?.postalCode}');
    if (fuelprice.isNotEmpty && fuelprice.first != null) {
      var valid = fuelprice.where(
              (el) {
            var elGPS = LatLng(el["gps"]?[0] ?? 1, el["gps"]?[1] ?? 1)
                .round(decimals: 5);
            var elementAddress = '${element.address?.streetName}${element
                .address?.streetNumber != null ? (" ${element.address
                ?.streetNumber ?? ""}") : ("")}'.toLowerCase();

            return el["address"].toLowerCase() == elementAddress ||
                elGPS == LatLng(element.position?.lat ?? 0,
                    element.position?.lon ?? 0).round(decimals: 5) ||
                elGPS == LatLng(
                    element.entryPoints?.first.position?.lat ?? 0,
                    element.entryPoints?.first.position?.lon ?? 0).round(
                    decimals: 5) ||
                elGPS == LatLng(element.viewport?.btmRightPoint?.lat ?? 0,
                    element.viewport?.btmRightPoint?.lon ?? 0).round(
                    decimals: 5) ||
                elGPS == LatLng(element.viewport?.topLeftPoint?.lat ?? 0,
                    element.viewport?.topLeftPoint?.lon ?? 0).round(
                    decimals: 5) ||
                ((
                    elGPS.latitude.compareTo(
                        element.viewport?.btmRightPoint?.lat ?? 0) <= 0 &&
                        elGPS.latitude.compareTo(
                            element.viewport?.topLeftPoint?.lat ?? 0) >=
                            0 &&
                        elGPS.longitude.compareTo(
                            element.viewport?.btmRightPoint?.lon ?? 0) <=
                            0 &&
                        elGPS.longitude.compareTo(
                            element.viewport?.topLeftPoint?.lon ?? 0) >= 0
                ) || (
                    elGPS.latitude.compareTo(
                        element.viewport?.btmRightPoint?.lat ?? 0) <= 0 &&
                        elGPS.latitude.compareTo(
                            element.viewport?.topLeftPoint?.lat ?? 0) >=
                            0 &&
                        elGPS.longitude.compareTo(
                            element.viewport?.btmRightPoint?.lon ?? 0) >=
                            0 &&
                        elGPS.longitude.compareTo(
                            element.viewport?.topLeftPoint?.lon ?? 0) <= 0
                ) || (
                    elGPS.latitude.compareTo(
                        element.viewport?.btmRightPoint?.lat ?? 0) >= 0 &&
                        elGPS.latitude.compareTo(
                            element.viewport?.topLeftPoint?.lat ?? 0) <=
                            0 &&
                        elGPS.longitude.compareTo(
                            element.viewport?.btmRightPoint?.lon ?? 0) <=
                            0 &&
                        elGPS.longitude.compareTo(
                            element.viewport?.topLeftPoint?.lon ?? 0) >= 0
                )
                );
          });

      if (valid.isNotEmpty && valid.first != null) {
        setState(() {
          poiPrices[element.id as String] = valid.first["price"];
        });
      }
    }
  }
}
