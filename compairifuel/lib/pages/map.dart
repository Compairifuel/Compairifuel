import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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