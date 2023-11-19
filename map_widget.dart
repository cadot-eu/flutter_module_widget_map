import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final Function(MapPosition, bool) onPositionChanged;
  final FollowOnLocationUpdate followOnLocationUpdate;
  final Stream<double?> followCurrentLocationStream;

  const MapWidget({
    required this.onPositionChanged,
    required this.followOnLocationUpdate,
    required this.followCurrentLocationStream,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(48.8566, 2.3522),
        initialZoom: 10.0,
        onPositionChanged: (position, hasGesture) =>
            onPositionChanged(position, hasGesture),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        const RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              '',
            ),
          ],
        ),
        CurrentLocationLayer(
          followOnLocationUpdate: followOnLocationUpdate,
          followCurrentLocationStream: followCurrentLocationStream,
          turnOnHeadingUpdate: TurnOnHeadingUpdate.always,
          style: const LocationMarkerStyle(
            marker: DefaultLocationMarker(
              child: Icon(
                Icons.navigation,
                color: Colors.white,
              ),
            ),
            markerSize: Size(30, 30),
            markerDirection: MarkerDirection.heading,
          ),
        ),
      ],
    );
  }
}
