class Map extends StatefulWidget implements Content {
  LocationService _locationService;
  UILayer? uiLayer;
  List<MapMarkerLayer> mapMarkerLayer;

  State<Map> createState() {
    MapState();
  }
  build(BuildContext context){
    //TODO
  }

  Map({super.key});
}

class _MapState extends State<Map> {
  MapController mapController;
  MapMarkerLayer userLocation;
  List<MapMarker> mapMarkerList;

  void initState(){
    //TODO
  }

  void dispose(){
    //TODO
  }

  void setUserLocationState(LatLng position){
    setState(()=>{
    userLocation = MapMarkerLayer(markers:[MapMarker(position)]);
    });
  }

  void setMapMarkListState(List<MapMarker> mapMarkers){
    setState(()=>{
    mapMarkerList = mapMarkers;
    });
  }

  build(BuildContext context){
    //TODO
  }
}