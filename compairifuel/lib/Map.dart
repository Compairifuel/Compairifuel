import 'package:compairifuel/Content.dart';
import 'package:compairifuel/LocationService.dart';
import 'package:compairifuel/MapMarker.dart';
import 'package:compairifuel/MapMarkerLayer.dart';
import 'package:compairifuel/UILayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget implements Content {
  final LocationService _locationService = LocationService();
  final UILayer? uiLayer;
  final List<MapMarkerLayer> mapMarkerLayer = const [
    MapMarkerLayer(markers: [MapMarker(point: LatLng(11, 11), child: Text(""))])];

  @override
  State<Map> createState() {
    return _MapState();
  }

  Map({super.key, this.uiLayer});
}

class _MapState extends State<Map> {
  MapController mapController = MapController();
  LatLng userLocation = const LatLng(0,0);
  List<MapMarker> mapMarkerList = [];

  @override
  void initState(){
    super.initState();

    widget._locationService.checkLocationAndSendNotification();

    widget._locationService.startListeningLocationUpdates((Position position) {
      if(LatLng(position.latitude,position.longitude) != userLocation) setUserLocationState(LatLng(position.latitude,position.longitude));
    });

    //TODO
  }

  @override
  void dispose(){
    super.dispose();
    //TODO
    widget._locationService.dispose();
  }

  void setUserLocationState(LatLng position){
    setState(() {
    userLocation = position;
    });
  }

  void setMapMarkListState(List<MapMarker> mapMarkers){
    setState(() {
    mapMarkerList = mapMarkers;
    });
  }

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: FlutterMap(
      options: MapOptions(
        initialCenter: userLocation,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MapMarkerLayer(markers: [MapMarker(point: userLocation, child: Image.asset("assets/images/location.png", width: 35, height: 35))]),
        MapMarkerLayer(markers: mapMarkerList),
        if(widget.uiLayer != null) widget.uiLayer!,
      ],
    ),);
    //TODO
  }
}