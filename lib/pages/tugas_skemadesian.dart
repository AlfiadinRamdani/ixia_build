import 'package:flutter/material.dart';

class TugasSkemadesian extends StatefulWidget {
  const TugasSkemadesian({super.key});

  @override
  State<TugasSkemadesian> createState() => _TugasSkemadesianState();
}

class _TugasSkemadesianState extends State<TugasSkemadesian> {
  bool _isCheklis = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Syarat dan ketentuan')),
        backgroundColor: const Color.fromARGB(235, 80, 255, 64),
      ),
      body: Column(
        children: [
          Text('saya menyetujui semua persyaratan'),

          Row(
            children: [
              Checkbox(
                value: _isCheklis,
                onChanged: (value) {
                  setState(() {
                    _isCheklis = value ?? false;
                  });
                },
              ),

              Text(
                _isCheklis
                    ? 'Pendaftaran diperbolehkan'
                    : 'Anda belum bisa melanjutkan',
              ),
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
