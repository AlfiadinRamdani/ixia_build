import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RiwayatKehadiran15 extends StatefulWidget {
  const RiwayatKehadiran15({super.key});

  @override
  State<RiwayatKehadiran15> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<RiwayatKehadiran15> {
  int _selectedIndex = 2; // Tab Kehadiran terpilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Latar belakang gradien abu-abu
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C2C2C), Color(0xFF8E8E8E), Color(0xFF2C2C2C)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Header Navigation & Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Riwayat Kehadiran',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Menyeimbangkan ikon back
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Daftar Card Riwayat Kehadiran
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 7, // Jumlah item placeholder
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white30, width: 1),
                      ),
                      child: Row(
                        children: [
                          // Kolom Hari & Tanggal
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hari',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tanggal',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Pembatas Garis Vertikal
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.white24,
                          ),
                          const SizedBox(width: 12),
                          // Kolom Check In
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Check In',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  '-- : -- : --',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Pembatas Garis Vertikal
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.white24,
                          ),
                          const SizedBox(width: 12),
                          // Kolom Check Out
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Check Out',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  '-- : -- : --',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Icon Checkbox / Status
                          const Icon(
                            Icons.check_box_outline_blank,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Tombol Hapus Riwayat
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 8, top: 4),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Aksi Hapus Riwayat
                    },
                    child: const Text(
                      'Hapus Riwayat',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        color: const Color(0xFF2C2C2C),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Tab Home
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.home_outlined, color: Colors.grey),
                  SizedBox(height: 4),
                  Text(
                    'Home',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Tab Profile (Lingkaran Tengah)
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 1),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF538D7C), width: 2),
                  color: Colors.amber,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ),

            // Tab Kehadiran (Aktif)
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.assignment_outlined, color: Color(0xFF538D7C)),
                  SizedBox(height: 4),
                  Text(
                    'Kehadiran',
                    style: TextStyle(
                      color: Color(0xFF538D7C),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
