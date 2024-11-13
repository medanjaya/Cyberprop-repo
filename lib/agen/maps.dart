import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late MapboxMapController mapController;
  final String mapboxAccessToken = 'YOUR_MAPBOX_ACCESS_TOKEN'; // Ganti dengan token API Mapbox Anda

  final LatLng center = LatLng(37.7749, -122.4194); // Lokasi pusat peta (contoh: San Francisco)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox'),
        backgroundColor: const Color.fromARGB(255, 76, 175, 80),
        centerTitle: true,
      ),
      body: MapboxMap(
        accessToken: mapboxAccessToken,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 10,
        ),
        styleString: MapboxStyles.MAPBOX_STREETS, // Anda bisa mengganti style peta di sini
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _addMarkers();
  }

  void _addMarkers() {
    // Tambahkan marker untuk lokasi tertentu
    mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(37.4219999, -122.0840575), // Lokasi Google Mountain View
        iconImage: "marker-15", // Anda bisa mengubah gambar marker sesuai kebutuhan
        iconSize: 1.5,
        textField: "Mountain View\nGoogle Office",
        textOffset: Offset(0, 2),
        textSize: 12.0,
      ),
    );

    mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(37.4848, -122.1484), // Lokasi Google Palo Alto
        iconImage: "marker-15",
        iconSize: 1.5,
        textField: "Palo Alto\nGoogle Office",
        textOffset: Offset(0, 2),
        textSize: 12.0,
      ),
    );

    mapController.addSymbol(
      SymbolOptions(
        geometry: LatLng(37.6272, -122.4313), // Lokasi Google San Bruno
        iconImage: "marker-15",
        iconSize: 1.5,
        textField: "San Bruno\nGoogle Office",
        textOffset: Offset(0, 2),
        textSize: 12.0,
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
