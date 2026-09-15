import 'package:flutter/material.dart';

class LoginScreenDB extends StatefulWidget {
  const LoginScreenDB({super.key});

  @override
  State<LoginScreenDB> createState() => _LoginScreenDBState();
}

class _LoginScreenDBState extends State<LoginScreenDB> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // =========================
                    // ICON
                    // =========================
                    const Icon(Icons.lock, size: 80, color: Colors.blue),

                    const SizedBox(height: 24),

                    // =========================
                    // TITLE
                    // =========================
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =========================
                    // SUBTITLE
                    // =========================
                    const Text(
                      'Silakan masuk ke akun Anda',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    const SizedBox(height: 32),

                    // =========================
                    // EMAIL
                    // =========================
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email wajib diisi';
                        } else if (!value.contains('@')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ), // TextFormField

                    const SizedBox(height: 16),

                    // =========================
                    // PASSWORD
                    // =========================
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Masukkan password',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // =========================
                    // BUTTON
                    // =========================
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Data '),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email: ${emailController.text}'),
                                ],
                              ), // Column
                              actions: [
                                TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: 
                                      (context) => 
                                        HalamanTerimaKasih(email: emailController.text),
                                  ), // MaterialPageRoute
                                );
                              },
                              child: Text('Lanjutkan'),
                            ), // TextButton
                              ],
                            ), // AlertDialog
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HalamanTerimaKasih extends StatelessWidget {
  final String email;
  const HalamanTerimaKasih({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Konfirmasi')),
      body: Center(
        child: Text(
          'Terima kasih, $email',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ), // Text
      ), // Center
    ); // Scaffold
  }
}
