import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_client.dart';
import 'dashboard_pages15.dart';

class RegisterPages15 extends StatefulWidget {
  const RegisterPages15({super.key});

  @override
  State<RegisterPages15> createState() => _RegisterPages15State();
}

class _RegisterPages15State extends State<RegisterPages15> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _batchController = TextEditingController();
  final _trainingIdController = TextEditingController();
  final _passwordController = TextEditingController();

  final Dio _dio = createDioClient();
  bool _isLoading = false;
  bool _isObscure = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _batchController.dispose();
    _trainingIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() => _isLoading = true);

    try {
      final response = await _dio.post(
        'register',
        data: {
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'batch': _batchController.text.trim(),
          'training_id': _trainingIdController.text.trim(),
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
        _showSnackBar(data['message'] ?? 'Registrasi gagal');
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
      appBar: AppBar(title: const Text('Registrasi Akun')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nama Lengkap')),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _batchController, decoration: const InputDecoration(labelText: 'Batch')),
            TextField(controller: _trainingIdController, decoration: const InputDecoration(labelText: 'ID Training')),
            TextField(
              controller: _passwordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                    child: const Text('Daftar'),
                  ),
          ],
        ),
      ),
    );
  }
}