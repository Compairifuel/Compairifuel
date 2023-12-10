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
  late LatLng? _userLocation;
  final MapController _mapController = MapController();
  // late CameraFit _cameraFit = CameraConstraint.containCenter(bounds: LatLngBounds(_userLocation!,_userLocation!);

  @override
  void initState() {
    super.initState();
    _locationService.startListeningLocationUpdates().listen((Position position) {
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);

        if(_userLocation != null){
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