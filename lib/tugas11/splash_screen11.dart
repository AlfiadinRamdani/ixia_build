import 'package:flutter/material.dart';
import 'package:ixia_build/tugas11/home_screen11.dart';
import 'package:ixia_build/tugas11/login_screen11.dart';
import 'package:ixia_build/tugas11/preferencehandler11.dart';
import 'package:ixia_build/tugas15/views/login_pages15.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.psychology_alt_outlined,
              size: 100,
              color: Color.fromARGB(255, 237, 5, 5),
            ),
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
