import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:compairifuel/src/global/providers/fuel_option_provider.dart';
import 'package:compairifuel/src/global/providers/gasstations_provider.dart';
import 'package:compairifuel/src/global/providers/location_provider.dart';
import 'package:compairifuel/src/global/ui/widgets/base_screen.dart';
import 'package:compairifuel/src/global/ui/widgets/nav_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(page: MapPage(), navBar: NavBar());
  }
}

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final MapController _mapController = MapController();
  bool isMapReady = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var fuelOption = ref.watch(fuelOptionProvider);

    LatLng? deviceLocation = ref.watch(mappedPositionProvider).valueOrNull;
    var gasStationList = ref.watch(gasStationListProvider).valueOrNull;

    if (context.mounted && deviceLocation != null && isMapReady) {
      _mapController.move(deviceLocation, _mapController.camera.zoom);
    }

    return ColoredBox(
        color: theme.colorScheme.primary,
        child: FlutterMap(
          options: MapOptions(
              onMapReady: () => setState(() {
                    isMapReady = true;
                  })),
          mapController: _mapController,
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            ...[deviceLocation].nonNulls.map((e) => MarkerLayer(markers: [
                  Marker(point: e, child: const Icon(Icons.accessibility))
                ])),
            if (gasStationList != null && gasStationList.isNotEmpty)
              MarkerLayer(
                  markers: gasStationList.map((el) {
                return Marker(
                    point: el.position.toLatLng(),
                    child: const Icon(Icons.local_gas_station_sharp));
              }).toList()),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  // Adjust the padding values as needed
                  child: DropdownButton<FuelOption>(
                    iconSize: 50.0,
                    value: fuelOption,
                    onChanged: (FuelOption? newValue) => ref
                        .read(fuelOptionProvider.notifier)
                        .setFuelOption(newValue!),
                    items: FuelOption.values.map((FuelOption value) {
                      return DropdownMenuItem<FuelOption>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
