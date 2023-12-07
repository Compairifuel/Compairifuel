import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void startListeningLocationUpdates() {
  Geolocator.getPositionStream().listen((Position position) {
    print(position);

    // Make request to TomTom Search API
    print('TomTom API request sent');
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

  void startListeningLocationUpdates() {
    Geolocator.getPositionStream().listen((Position position) {
      searchNearby(position.latitude, position.longitude);
      print(position);
    });
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

  @override
  void initState() {
    super.initState();
    _locationService.startListeningLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<Position>(
        stream: _locationService.getCurrentLocation().asStream(),
        builder: (context, snapshot) {
            if (snapshot.hasData) {
              Position position = snapshot.data!;
              return Text(
                'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
              );
            }
            else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
              }
            else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}