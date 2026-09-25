import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_client.dart';
import 'theme_manager.dart';
import 'login_pages15.dart';

class ProfilePages15 extends StatefulWidget {
  const ProfilePages15({super.key});

  @override
  State<ProfilePages15> createState() => _ProfilePages15State();
}

class _ProfilePages15State extends State<ProfilePages15> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final Dio _dio = createDioClient();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  Future<void> _getProfile() async {
    try {
      final response = await _dio.get('profile');
      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        _nameController.text = data['name'] ?? data['nama'] ?? '';
        _emailController.text = data['email'] ?? '';
      }
    } catch (e) {
      debugPrint('Profile fetch error: $e');
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);
    try {
      final response = await _dio.put(
        'edit-profile',
        data: {'name': _nameController.text, 'email': _emailController.text},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil berhasil diubah')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal mengubah profil')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPages15()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nama')),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeNotifier.value == ThemeMode.dark,
              onChanged: (val) => themeNotifier.toggleTheme(val),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _updateProfile, child: const Text('Simpan Perubahan')),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _logout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}