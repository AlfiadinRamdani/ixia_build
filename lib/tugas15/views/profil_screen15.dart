import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ixia_build/tugas15/views/login_pages15.dart';
import 'package:ixia_build/tugas15/views/edit_profile_screen15.dart';
import 'package:ixia_build/tugas15/services/simpan_token.dart';
import 'package:ixia_build/tugas15/services/api_services.dart';
import 'package:ixia_build/tugas15/services/dio_client.dart';
import 'package:ixia_build/tugas15/services/theme_provider.dart';
import 'package:ixia_build/tugas15/models/profil_models.dart';

class ProfilScreen15 extends StatefulWidget {
  const ProfilScreen15({super.key});

  @override
  State<ProfilScreen15> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilScreen15> {
  int _selectedIndex = 1; // Tab Profile terpilih

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
              // Header
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // Avatar Profil
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.lightBlueAccent, width: 3),
                  color: Colors.amber,
                ),
                child: const Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 40),

              // Menu Options Container 1
              Container(
                color: const Color(0xFF4A4A4A),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.person_outline,
                        color: Color(0xFF538D7C),
                      ),
                      title: const Text(
                        'Ubah Profil',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () async {
                        // Fetch latest profile data before navigating to edit screen
                        final dio = createDioClient();
                        final apiService = ApiService(dio);
                        try {
                          final profile = await apiService.profiluser();
                          if (!mounted) return;
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditProfileScreen15(currentProfile: profile),
                            ),
                          );
                          // If profile was updated, refresh the screen
                          if (result != null && mounted) {
                            setState(() {});
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Gagal memuat profil: $e'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        }
                      },
                    ),
                    const Divider(height: 1, color: Colors.black26),
                    ListTile(
                      leading: const Icon(
                        Icons.lock_outline,
                        color: Color(0xFF538D7C),
                      ),
                      title: const Text(
                        'Ubah Kata Sandi',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Colors.black26),
                    // Dark Mode Toggle
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, _) {
                        return ListTile(
                          leading: Icon(
                            themeProvider.isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: const Color(0xFF538D7C),
                          ),
                          title: Text(
                            themeProvider.isDarkMode
                                ? 'Mode Gelap'
                                : 'Mode Terang',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (_) => themeProvider.toggleTheme(),
                            activeColor: const Color(0xFF538D7C),
                          ),
                          onTap: () => themeProvider.toggleTheme(),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Menu Options Container 2 (Keluar)
              Container(
                color: const Color(0xFF4A4A4A),
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text(
                    'Keluar',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () async {
                    // Clear stored authentication token before returning to login screen
                    await SimpanToken.hapusToken();
                    if (!mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPages15(),
                      ),
                      (route) => false,
                    );
                  },
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
            // Home
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

            // Profile (Active)
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF538D7C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Profile',
                    style: TextStyle(color: Color(0xFF538D7C), fontSize: 12),
                  ),
                ],
              ),
            ),

            // Kehadiran
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.assignment_outlined, color: Colors.grey),
                  SizedBox(height: 4),
                  Text(
                    'Kehadiran',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
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
