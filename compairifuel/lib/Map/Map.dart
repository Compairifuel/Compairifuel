import 'package:compairifuel/Content.dart';
import 'package:compairifuel/LocationService.dart';
import 'package:compairifuel/Navbar.dart';
import 'package:compairifuel/Pagination.dart';
import './MapMarker.dart';
import './MapMarkerLayer.dart';
import 'package:compairifuel/UILayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:compairifuel/Manual/UserManual.dart';
import 'package:compairifuel/Page.dart' as PageComponent;

class Map extends StatefulWidget implements Content {
  final LocationService _locationService = LocationService();
  final UILayer? uiLayer = null;
  final List<MapMarkerLayer> mapMarkerLayer = const [
    MapMarkerLayer(markers: [MapMarker(point: LatLng(11, 11), child: Text(""))])];

  @override
  State<Map> createState() {
    return _MapState();
  }

  Map({super.key});
}

class _MapState extends State<Map> {
  MapController mapController = MapController();
  LatLng userLocation = const LatLng(0,0);
  List<MapMarker> mapMarkerList = [];

  @override
  void initState(){
    super.initState();

    widget._locationService.checkLocationAndSendNotification().onError(
            (e, _) async => {

              if(await Navigator.push(context, MaterialPageRoute(builder: (context) => enableLocation()))) widget._locationService.checkLocationAndSendNotification(),
            });

    //TODO
  }

  @override
  void dispose(){
    widget._locationService.dispose();
    super.dispose();
    //TODO
  }

  void setUserLocationState(LatLng position){
    // debugDumpApp();
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

    //FIXME: This is a temporary solution to get the map to update the user location and not thow an error for state not mounted.
    widget._locationService.startListeningLocationUpdates(context,(Position position) {
      if(LatLng(position.latitude,position.longitude) != userLocation) setUserLocationState(LatLng(position.latitude,position.longitude));
    });

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



class enableLocation extends StatelessWidget {
  const enableLocation({super.key});
  @override
  Widget build(BuildContext context){
   final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(20.0),child:Text("De map functionaliteit heeft jouw locatie nodig om te werken.")),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context,true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.background,
              ),
              child: const Text("Enable Location"),
            ),

            InkWell(child: const Text("Je kan de locatie later in de instellingen aanpassen."),onTap:()=>Navigator.push(context,MaterialPageRoute(builder: (context) => PageComponent.Page(title: "title", content: UserManual(), navbar: Navbar(), pagination: const Pagination())))),
          ],
        ),
      ),
    );
  }
}
