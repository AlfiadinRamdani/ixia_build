import 'package:flutter/material.dart';
import 'package:ixia_build/tugas12/databasehelper12.dart';
import 'package:ixia_build/tugas12/user12.dart';

class UserPagetugas extends StatefulWidget {
  const UserPagetugas({super.key});

  @override
  State<UserPagetugas> createState() => _UserPagetugasState();
}

class _UserPagetugasState extends State<UserPagetugas> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();

  // Variabel untuk mengontrol visibilitas password
  bool _isObscure = true;

  // Future untuk mengambil data UserModel
  late Future<List<UserModel>> users;

  @override
  void initState() {
    super.initState();
    users = DatabaseHelper.instance.getAllUsers();
  }

  // Fungsi simpan data
  Future<void> simpanData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = UserModel(
      nama: namaController.text,
      email: emailController.text,
      noHp: noHpController.text,
      password: passwordController.text,
      asalKota: kotaController.text,
    );

    await DatabaseHelper.instance.registerUser(user);

    // Kosongkan form
    namaController.clear();
    emailController.clear();
    noHpController.clear();
    passwordController.clear();
    kotaController.clear();

    // Ambil ulang data dari database
    setState(() {
      users = DatabaseHelper.instance.getAllUsers();
    });
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    passwordController.dispose();
    kotaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pendaftaran User')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // =========================
            // FORM
            // =========================
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Nama
                  TextFormField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Email
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
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
                  const SizedBox(height: 12),

                  // Nomor HP
                  TextFormField(
                    controller: noHpController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Nomor HP',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor HP wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Password (Sudah ditambahkan toggle show/hide)
                  TextFormField(
                    controller: passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password wajib diisi';
                      }
                      if (value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Asal Kota
                  TextFormField(
                    controller: kotaController,
                    decoration: const InputDecoration(
                      labelText: 'Asal Kota',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Asal kota wajib diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: simpanData,
                      child: const Text(
                        'Daftar',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          simpanData();
                        }
                      },
                      child: Text('Register'),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Data Peserta',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // =========================
            // LIST DATA DATABASE
            // =========================
            FutureBuilder<List<UserModel>>(
              future: users,
              builder: (context, snapshot) {
                // Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Error
                if (snapshot.hasError) {
                  return Text('Terjadi error: ${snapshot.error}');
                }

                // Tidak ada data
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Belum ada peserta'),
                  );
                }

                final data = snapshot.data!;

                // Menampilkan data
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final user = data[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text(
                          user.nama,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.email),
                            Text(user.noHp),
                            Text(user.asalKota),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}