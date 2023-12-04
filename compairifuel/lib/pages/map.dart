import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  late LatLng _userLocation;

  @override
  void initState() {
    super.initState();
    _locationService.startListeningLocationUpdates().listen((Position position) {
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            center: _userLocation ?? LatLng(0, 0),
            zoom: 13.0,
          ),
          layers: [
            TileLayer(
              urlTemplate:
              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              //useragend: ik heb geen idee wat dit is
            ),
            MarkerLayer(
              markers: [
                if (_userLocation != null)
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: _userLocation,
                      child: FlutterLogo(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}