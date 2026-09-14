import 'package:flutter/material.dart';

class LatihanTimepickter extends StatefulWidget {
  const LatihanTimepickter({super.key});

  @override
  State<LatihanTimepickter> createState() => _LatihanTimepickterState();
}

class _LatihanTimepickterState extends State<LatihanTimepickter> {
  String _waktu = "Belum memilih jam";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan timepicker'),
        backgroundColor: const Color.fromARGB(255, 236, 12, 12),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_waktu, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Pilih Jam'),
              onPressed: () async {
                // Munculkan time picker
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                // Jika user memilih jam (tidak klik cancel)
                if (picked != null) {
                  setState(() {
                    _waktu = "${picked.hour}:${picked.minute}";
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
