import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SampleMaps extends StatefulWidget {
  const SampleMaps({super.key});

  @override
  State<SampleMaps> createState() => _SampleMapsState();
}

class _SampleMapsState extends State<SampleMaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('help')
      ),
      body: SizedBox(
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(3.507621918799457, 98.6134280949127),
            initialZoom: 16.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              retinaMode: true,
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(3.507621918799457, 98.6134280949127),
                  width: 64.0,
                  height: 64.0,
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 64.0,
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