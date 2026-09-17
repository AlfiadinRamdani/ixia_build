import 'package:flutter/material.dart';
import 'package:ixia_build/tugas11/login_screen11.dart';
import 'package:ixia_build/tugas11/preferencehandler11.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logout(BuildContext context) async {
    await PreferenceHandlerTugas.setLogin(false);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(
          showLogoutMessage: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Selamat Datang di Home',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}