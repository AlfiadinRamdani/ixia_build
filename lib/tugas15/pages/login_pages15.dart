import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_client.dart';
import 'dashboard_pages15.dart';
import 'register_pages15.dart';

class LoginPages15 extends StatefulWidget {
  const LoginPages15({super.key});

  @override
  State<LoginPages15> createState() => _LoginPages15State();
}

class _LoginPages15State extends State<LoginPages15> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final Dio _dio = createDioClient();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);

    try {
      final response = await _dio.post(
        'login',
        data: {
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
        },
      );

      final data = response.data;
      if (response.statusCode == 200 || response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = data['token'] ?? data['access_token'] ?? data['data']?['token'];

        if (token != null) {
          await prefs.setString('token', token);
        }

        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPages15()),
          (route) => false,
        );
      } else {
        _showSnackBar(data['message'] ?? 'Login gagal');
      }
    } on DioException catch (e) {
      String msg = 'Terjadi kesalahan koneksi';
      if (e.response?.data != null && e.response?.data is Map) {
        msg = e.response?.data['message'] ?? msg;
      }
      _showSnackBar(msg);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Absensi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                    child: const Text('Masuk'),
                  ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPages15())),
              child: const Text('Belum punya akun? Daftar di sini'),
            ),
          ],
        ),
      ),
    );
  }
}