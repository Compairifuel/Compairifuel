import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  late StreamSubscription<Position>? _locationSubscription;
  late bool isLocationEnabled;

  Future<void> checkLocationAndSendNotification() async {
    // TODO
    bool isLocationServiceEnabled = await _isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      // TODO
      Geolocator.requestPermission();

    }
  }

  Future<bool> _isLocationServiceEnabled() async {
    // TODO
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  // Future<Position> getCurrentLocation() async {
  //   // TODO
  //
  // }

  void startListeningLocationUpdates(void Function(Position) onLocationUpdate){
    // TODO
    _locationSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,)
    )
        .listen(onLocationUpdate);
  }

  void dispose(){
    _locationSubscription!.cancel();
  }
}