import 'package:flutter/material.dart';
import 'package:ixia_build/tugas11/home_screen11.dart';
import 'package:ixia_build/tugas11/login_screen11.dart';
import 'package:ixia_build/tugas11/preferencehandler11.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      final nextScreen = PreferenceHandlerTugas.isLogin
          ? const HomeScreen()
          : const LoginScreen();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.mobile_friendly, size: 100),
            SizedBox(height: 20),
            Text(
              'Siap Untuk Pusing',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
