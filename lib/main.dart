import 'package:flutter/material.dart';
import 'package:ixia_build/tugas15/pages/dashboard_pages15.dart';
import 'package:ixia_build/tugas15/pages/login_pages15.dart';
import 'package:ixia_build/tugas15/pages/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  // Memastikan binding Flutter siap sebelum menjalankan kode async
  WidgetsFlutterBinding.ensureInitialized();

  // Cek apakah user sudah memiliki token login di SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  runApp(MyApp(isLoggedIn: token != null && token.isNotEmpty));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    // Mendengarkan perubahan pada themeNotifier untuk merender ulang tema
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'Aplikasi Absensi',
          debugShowCheckedModeBanner: false,

          // Pengaturan Tema Terintegrasi
          themeMode: currentMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
          ),

          // Logika Routing Awal: jika token ada langsung ke Dashboard, jika tidak ke Login
          home: isLoggedIn ? const DashboardPages15() : const LoginPages15(),
        );
      },
    );
  }
}