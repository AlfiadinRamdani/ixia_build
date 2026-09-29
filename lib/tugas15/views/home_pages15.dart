import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:ixia_build/tugas15/models/check_in_models.dart';
import 'package:ixia_build/tugas15/models/check_out_models.dart';
import 'package:ixia_build/tugas15/models/profil_models.dart';
import 'package:ixia_build/tugas15/services/api_services.dart';
import 'package:ixia_build/tugas15/services/dio_client.dart';

class HomePages15 extends StatefulWidget {
  const HomePages15({super.key});

  @override
  State<HomePages15> createState() => _HomePages15State();
}

class _HomePages15State extends State<HomePages15> {
  int _currentIndex = 0;
  bool _isLoading = true;
  bool _isActionLoading = false;

  late final ApiService _apiService;

  // Data State
  ProfilModels? _userProfile;
  CheckIn? _lastCheckIn;
  CheckOut? _lastCheckOut;

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    _apiService = ApiService(dio);
    _fetchInitialData();
  }

  // 1. Ambil Data Profil Pengguna Saat Halaman Dimuat
  Future<void> _fetchInitialData() async {
    setState(() => _isLoading = true);
    try {
      final profile = await _apiService.profiluser();
      setState(() {
        _userProfile = profile;
      });
    } on DioException catch (e) {
      _showSnackBar(
        e.response?.data['message'] ?? 'Gagal memuat profil',
        isError: true,
      );
    } catch (e) {
      _showSnackBar('Terjadi kesalahan: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // 2. Fungsi API untuk Check-In
  Future<void> _handleCheckIn() async {
    setState(() => _isActionLoading = true);
    try {
      // Contoh koordinat & alamat dummy (bisa disesuaikan dengan package geolocator)
      final request = CheckInModels(
        checkInLat: "-6.200000",
        checkInLng: "106.816666",
        checkInAddress: "Jakarta Central Office",
        status: "Hadir",
      );

      final response = await _apiService.checkuser(request);

      setState(() {
        _lastCheckIn = response;
      });

      _showSnackBar(response.message ?? 'Check-In Berhasil!');
    } on DioException catch (e) {
      _showSnackBar(
        e.response?.data['message'] ?? 'Gagal Check-In',
        isError: true,
      );
    } catch (e) {
      _showSnackBar('Error: $e', isError: true);
    } finally {
      setState(() => _isActionLoading = false);
    }
  }

  // 3. Fungsi API untuk Check-Out
  Future<void> _handleCheckOut() async {
    setState(() => _isActionLoading = true);
    try {
      final request = CheckOutModels(
        checkOutLat: "-6.200000",
        checkOutLng: "106.816666",
        checkOutLocation: "Office HQ",
        checkOutAddress: "Jakarta Central Office",
      );

      final response = await _apiService.Checkuser(request);

      setState(() {
        _lastCheckOut = response;
      });

      _showSnackBar(response.message ?? 'Check-Out Berhasil!');
    } on DioException catch (e) {
      _showSnackBar(
        e.response?.data['message'] ?? 'Gagal Check-Out',
        isError: true,
      );
    } catch (e) {
      _showSnackBar('Error: $e', isError: true);
    } finally {
      setState(() => _isActionLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  // Helper Format Waktu
  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--:--';
    final localTime = dateTime.toLocal();
    final hour = localTime.hour.toString().padLeft(2, '0');
    final minute = localTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C2C2C), Color(0xFF6E6E6E), Color(0xFF2C2C2C)],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFF538D7C)),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Header (Greeting & Profile)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Selamat Pagi, 👋',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _userProfile?.data?.name ?? 'Pengguna',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFF538D7C),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // 2. Card Presensi Utama
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B3B3B),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Informasi Lokasi
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _lastCheckIn?.data?.checkInAddress ??
                                        'Lokasi Belum Terdeteksi',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Box Status Check-In & Check-Out
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF538D7C),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Check In Status
                                  Column(
                                    children: [
                                      const Text(
                                        'Check In',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatTime(
                                          _lastCheckIn?.data?.checkIn,
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: Colors.white38,
                                  ),
                                  // Check Out Status
                                  Column(
                                    children: [
                                      const Text(
                                        'Check Out',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatTime(
                                          _lastCheckOut?.data?.checkOut,
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Tombol Aksi Presensi
                            _isActionLoading
                                ? const CircularProgressIndicator(
                                    color: Color(0xFF538D7C),
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: _handleCheckIn,
                                          icon: const Icon(Icons.login),
                                          label: const Text('Check In'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF538D7C,
                                            ),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: _handleCheckOut,
                                          icon: const Icon(Icons.logout),
                                          label: const Text('Check Out'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.redAccent,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 3. Menu Utama
                      const Text(
                        'Menu Utama',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMenuItem(Icons.calendar_month, 'Izin', () {}),
                          _buildMenuItem(Icons.history, 'Riwayat', () {}),
                          _buildMenuItem(
                            Icons.account_balance_wallet,
                            'Klaim',
                            () {},
                          ),
                          _buildMenuItem(Icons.more_horiz, 'Lainnya', () {}),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // 4. Riwayat Kehadiran Terbaru
                      const Text(
                        'Riwayat Kehadiran',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildHistoryCard(
                        'Hari Ini',
                        _formatTime(_lastCheckIn?.data?.checkIn),
                        _formatTime(_lastCheckOut?.data?.checkOut),
                        _lastCheckIn?.data?.status ?? 'Tepat Waktu',
                      ),
                    ],
                  ),
                ),
        ),
      ),

      // 5. Bottom Navigation Bar
      bottomNavigationBar: Container(
        color: const Color(0xFF2C2C2C),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: _currentIndex == 0
                        ? const Color(0xFF538D7C)
                        : Colors.white54,
                    size: 28,
                  ),
                  onPressed: () => setState(() => _currentIndex = 0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.assignment_turned_in,
                    color: _currentIndex == 1
                        ? const Color(0xFF538D7C)
                        : Colors.white54,
                    size: 28,
                  ),
                  onPressed: () => setState(() => _currentIndex = 1),
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: _currentIndex == 2
                        ? const Color(0xFF538D7C)
                        : Colors.white54,
                    size: 28,
                  ),
                  onPressed: () => setState(() => _currentIndex = 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF3B3B3B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFF538D7C), size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(
    String date,
    String inTime,
    String outTime,
    String status,
  ) {
    final bool isLate = status == 'Terlambat';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF3B3B3B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isLate
                      ? Colors.redAccent.withOpacity(0.2)
                      : Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLate ? Icons.access_time_filled : Icons.check_circle,
                  color: isLate ? Colors.redAccent : Colors.green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Masuk: $inTime | Keluar: $outTime',
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          Text(
            status,
            style: TextStyle(
              color: isLate ? Colors.redAccent : const Color(0xFF538D7C),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
