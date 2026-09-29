import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ixia_build/extension/navigator.dart';
import 'package:ixia_build/tugas15/models/register_models.dart';
import 'package:ixia_build/tugas15/services/api_services.dart';
import 'package:ixia_build/tugas15/services/dio_client.dart';
import 'package:ixia_build/tugas15/services/simpan_token.dart';
import 'package:ixia_build/tugas15/views/login_pages15.dart';

class RegisterScreen15 extends StatefulWidget {
  const RegisterScreen15({super.key});

  @override
  State<RegisterScreen15> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen15> {
  final _registrasiForm = GlobalKey<FormState>();
  final _inpFullNameRegister = TextEditingController();
  final _inpEmailRegister = TextEditingController();
  final _inpPassRegister = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  late final ApiService _apiService;

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    _apiService = ApiService(dio);
  }

  @override
  void dispose() {
    _inpFullNameRegister.dispose();
    _inpEmailRegister.dispose();
    _inpPassRegister.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_registrasiForm.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final requestBody = RegisterModel(
      name: _inpFullNameRegister.text.trim(),
      email: _inpEmailRegister.text.trim(),
      password: _inpPassRegister.text,
    );

    try {
      final response = await _apiService.registeruser(requestBody);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${response.message ?? "Registrasi berhasil!"} Silakan login.',
          ),
          backgroundColor: Colors.green,
        ),
      );

       Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPages15()),
            );
    } on DioException catch (e) {
      if (!mounted) return;

      String errorMessage = 'Terjadi kesalahan saat registrasi';
      if (e.response?.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;
        if (data['message'] != null) {
          errorMessage = data['message'].toString();
        } else if (data['errors'] != null && data['errors'] is Map) {
          final errors = data['errors'] as Map;
          if (errors.isNotEmpty) {
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) {
              errorMessage = firstError.first.toString();
            }
          }
        }
      } else if (e.message != null) {
        errorMessage = e.message!;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
            colors: [Color(0xFF2C2C2C), Color(0xFF6E6E6E), Color(0xFF2C2C2C)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Header Navigasi & Judul
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
                        'Presence App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 48,
                    ), // Menyeimbangkan posisi tombol back
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Card Register Utama
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B3B3B),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Form(
                        key: _registrasiForm,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Register Account',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Register Your\nAccount',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white70,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Input Nama
                            TextFormField(
                              controller: _inpFullNameRegister,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Nama',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama harus diisi !';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 14),
                            // Input No HP

                            // Input Email
                            TextFormField(
                              controller: _inpEmailRegister,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email wajib diisi';
                                }
                                if (!value.contains('@')) {
                                  return 'Email tidak valid';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),
                            // Input Kata Sandi
                            TextFormField(
                              controller: _inpPassRegister,
                              obscureText: _obscurePassword,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Kata Sandi',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Tombol Register / Log In
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _handleRegister,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF538D7C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFFFFFFff),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
