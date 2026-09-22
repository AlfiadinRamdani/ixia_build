import 'package:flutter/material.dart';
import 'databasehelper13.dart';
import 'user13.dart';
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User13> users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  // =========================================================
  // LOAD DATA
  // =========================================================

  Future<void> loadUsers() async {
    final data = await Databasehelper13.instance.getUsers();

    setState(() {
      users = data
          .map(
            (item) => User13.fromMap(item),
          )
          .toList();
    });
  }

  // =========================================================
  // TAMBAH DATA
  // =========================================================

  Future<void> addUser() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserFormPage(),
      ),
    );

    if (result == true) {
      await loadUsers();
    }
  }

  // =========================================================
  // EDIT DATA
  // =========================================================

  Future<void> editUser(User13 user) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserFormPage(
          user: user,
        ),
      ),
    );

    if (result == true) {
      await loadUsers();
    }
  }

  // =========================================================
  // DELETE DATA
  // =========================================================

  Future<void> deleteUser(User13 user) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Konfirmasi Hapus',
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus '
            'data "${user.name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text('Ya, Hapus'),
            ),
          ],
        );
      },
    );

    // Jika user memilih "Ya, Hapus"
    if (result == true) {
      await Databasehelper13.instance.deleteUser(
        user.id!,
      );

      // Refresh ListView
      await loadUsers();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data ${user.name} berhasil dihapus',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Pendaftaran User',
        ),
        centerTitle: true,
      ),

      // =====================================================
      // LIST DATA
      // =====================================================

      body: users.isEmpty
          ? const Center(
              child: Text(
                'Belum ada data user',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        user.name.isNotEmpty
                            ? user.name[0].toUpperCase()
                            : '?',
                      ),
                    ),

                    title: Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email: ${user.email}',
                          ),
                          Text(
                            'No. HP: ${user.phone}',
                          ),
                        ],
                      ),
                    ),

                    // =================================================
                    // ICON EDIT & DELETE
                    // =================================================

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // EDIT
                        IconButton(
                          tooltip: 'Edit',
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            editUser(user);
                          },
                        ),

                        // DELETE
                        IconButton(
                          tooltip: 'Hapus',
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteUser(user);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      // =====================================================
      // BUTTON TAMBAH
      // =====================================================

      floatingActionButton: FloatingActionButton(
        onPressed: addUser,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

// =========================================================
// FORM USER
// =========================================================

class UserFormPage extends StatefulWidget {
  final User13? user;

  const UserFormPage({
    super.key,
    this.user,
  });

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // =========================================================
  // CEK MODE EDIT
  // =========================================================

  bool get isEdit => widget.user != null;

  @override
  void initState() {
    super.initState();

    // =======================================================
    // JIKA EDIT, MASUKKAN DATA LAMA KE FORM
    // =======================================================

    if (widget.user != null) {
      nameController.text = widget.user!.name;
      emailController.text = widget.user!.email;
      phoneController.text = widget.user!.phone;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  // =========================================================
  // SIMPAN DATA
  // =========================================================

  Future<void> saveData() async {
    // Validasi form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    // =======================================================
    // CEK EMAIL
    // =======================================================

    final emailExists =
      await Databasehelper13.instance.isEmailRegistered(
      email,
      excludeId: isEdit
          ? widget.user!.id
          : null,
    );

    if (emailExists) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email sudah terdaftar!',
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    // =======================================================
    // CEK NOMOR HP
    // =======================================================

    final phoneExists =
        await Databasehelper13.instance.isPhoneRegistered(
      phone,
      excludeId: isEdit
          ? widget.user!.id
          : null,
    );

    if (phoneExists) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nomor HP sudah terdaftar!',
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    // =======================================================
    // DATA YANG AKAN DISIMPAN
    // =======================================================

    final data = {
      'name': name,
      'email': email,
      'phone': phone,
    };

    // =======================================================
    // UPDATE
    // =======================================================

    if (isEdit) {
      await Databasehelper13.instance.updateUser(
        widget.user!.id!,
        data,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data berhasil diperbarui',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }

    // =======================================================
    // INSERT
    // =======================================================

    else {
      await Databasehelper13.instance.insertUser(
        data,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data berhasil ditambahkan',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }

    // Kembali ke halaman list
    Navigator.pop(
      context,
      true,
    );
  }

  // =========================================================
  // BUILD FORM
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit
              ? 'Edit Data User'
              : 'Tambah Data User',
        ),
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // =================================================
              // NAMA
              // =================================================

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // =================================================
              // EMAIL
              // =================================================

              TextFormField(
                controller: emailController,
                keyboardType:
                    TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Email wajib diisi';
                  }

                  if (!value.contains('@')) {
                    return 'Email tidak valid';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              // =================================================
              // NOMOR HP
              // =================================================

              TextFormField(
                controller: phoneController,
                keyboardType:
                    TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP',
                  prefixIcon: Icon(
                    Icons.phone,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Nomor HP wajib diisi';
                  }

                  if (value.length < 10) {
                    return 'Nomor HP minimal 10 digit';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // =================================================
              // BUTTON SIMPAN
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: saveData,
                  icon: Icon(
                    isEdit
                        ? Icons.save
                        : Icons.add,
                  ),
                  label: Text(
                    isEdit
                        ? 'Simpan Perubahan'
                        : 'Daftar',
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