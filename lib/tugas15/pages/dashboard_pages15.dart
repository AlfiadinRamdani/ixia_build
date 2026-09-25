import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import 'dio_client.dart';
import 'history_pages15.dart';
import 'profile_page15.dart';
import 'map_detail_pages15.dart';

class DashboardPages15 extends StatefulWidget {
  const DashboardPages15({super.key});

  @override
  State<DashboardPages15> createState() => _DashboardPages15State();
}

class _DashboardPages15State extends State<DashboardPages15> {
  String _userName = 'Pengguna';
  bool _isLoading = false;
  Map<String, dynamic>? _todayAttendance;

  final Dio _dio = createDioClient();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final response = await _dio.get('profile');
      if (response.statusCode == 200) {
        final resData = response.data;
        String fetchedName = 'Pengguna';

        if (resData is Map) {
          fetchedName = resData['nama'] ?? resData['name'] ?? resData['data']?['name'] ?? 'Pengguna';
        }

        if (mounted) setState(() => _userName = fetchedName);
      }
    } catch (_) {}
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('Layanan lokasi mati.');
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _absen(String endpoint) async {
    setState(() => _isLoading = true);
    Position? pos = await _getCurrentLocation();

    if (pos == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      final response = await _dio.post(
        endpoint,
        data: {'latitude': pos.latitude, 'longitude': pos.longitude},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSnackBar('Absen Berhasil!');
        if (mounted) {
          setState(() {
            _todayAttendance = {
              'type': endpoint == 'absen/check-in' ? 'Masuk' : 'Pulang',
              'time': DateTime.now().toString().substring(11, 16),
              'lat': pos.latitude,
              'lng': pos.longitude,
            };
          });
        }
      }
    } on DioException catch (e) {
      _showSnackBar(e.response?.data?['message'] ?? 'Terjadi kesalahan koneksi');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Absensi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryPages15())),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePages15())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selamat Datang, $_userName!', style: Theme.of(context).textTheme.headlineSmall),
            Text(DateTime.now().toString().substring(0, 10), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 20),
            Row(
  children: [
    Expanded(
      child: ElevatedButton(
        // Sesuaikan dengan endpoint Laravel: 'absen/masuk' atau 'absen/check-in'
        onPressed: _isLoading ? null : () => _absen('/absen/check-in'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text('Absen Masuk'),
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: ElevatedButton(
        // Sesuaikan dengan endpoint Laravel: 'absen/keluar' atau 'absen/check-out'
        onPressed: _isLoading ? null : () => _absen('absen/keluar'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text('Absen Pulang'),
      ),
    ),
  ],
),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                title: Text(_todayAttendance != null ? 'Status: Absen ${_todayAttendance!['type']}' : 'Belum Absen Hari Ini'),
                subtitle: _todayAttendance != null
                    ? Text('Jam: ${_todayAttendance!['time']}\nLat: ${_todayAttendance!['lat']}, Lng: ${_todayAttendance!['lng']}')
                    : null,
                trailing: _todayAttendance != null
                    ? IconButton(
                        icon: const Icon(Icons.map),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapDetailPage(lat: _todayAttendance!['lat'], lng: _todayAttendance!['lng']),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}