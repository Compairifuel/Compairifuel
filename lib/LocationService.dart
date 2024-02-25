class LocationService {
  StreamSubscription<Position> _locationSubscribtion;
  bool isLocationEnabled;

  Future<void> checkLocationAndSendNotification(){
    // TODO
  }

  Future<bool> _isLocationServiceEnabled(){
    // TODO
  }

  Future<Position> getCurrentLocation(){
    // TODO
  }

  void startListeningLocationUpdates(void Function(Position) onLocationUpdate){
    // TODO
  }

  void dispose(){
    __locationSubscribtion.cancel();
  }
}