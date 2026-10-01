import 'package:flutter/material.dart';
import 'package:ixia_build/tugas11/home_screen11.dart';
import 'package:ixia_build/tugas11/login_screen11.dart';
import 'package:ixia_build/tugas11/preferencehandler11.dart';
import 'package:ixia_build/tugas15/views/login_pages15.dart';

class Splash15 extends StatefulWidget {
  const Splash15({super.key});

  @override
  State<Splash15> createState() => _Splash15State();
}

class _Splash15State extends State<Splash15> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final nextScreen = PreferenceHandlerTugas.isLogin
          ? const HomeScreen()
          : const LoginPages15();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan gambar dari Asset Lokal
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/ixia.jpg', // Sesuaikan path asset gambar Anda di sini
                width: 300,
                height: 500,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    size: 100,
                    color: Color.fromARGB(255, 77, 215, 18),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Alfiadin Ramdani',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 3, 11),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
