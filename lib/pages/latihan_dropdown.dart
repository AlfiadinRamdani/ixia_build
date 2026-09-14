import 'package:flutter/material.dart';

class LatihanDropdown extends StatefulWidget {
  const LatihanDropdown({super.key});

  @override
  State<LatihanDropdown> createState() => LatihanDropdownState();
}

class LatihanDropdownState extends State<LatihanDropdown> {
  String selectedItem = 'elektronik';
  final List<String> menuList = ['elektronik', 'pakaian', 'makanan', 'lainnya'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilihan produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih produk',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButton<String>(
              value: selectedItem,
              isExpanded: true,
              items: menuList.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    selectedItem = value;
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
