import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDetailPage extends StatelessWidget {
  final double lat;
  final double lng;

  const MapDetailPage({super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    final LatLng location = LatLng(lat, lng);

    return Scaffold(
      appBar: AppBar(title: const Text('Lokasi Absen')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: location, zoom: 16),
        markers: {
          Marker(
            markerId: const MarkerId('absen_loc'),
            position: location,
            infoWindow: const InfoWindow(title: 'Lokasi Anda'),
          ),
        },
      ),
    );
  }
}