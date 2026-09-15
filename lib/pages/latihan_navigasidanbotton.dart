import 'package:flutter/material.dart';

class LatihanNavigasidanbotton extends StatefulWidget {
  const LatihanNavigasidanbotton({super.key});

  @override
  State<LatihanNavigasidanbotton> createState() =>
      _LatihanNavigasidanbottonState();
}

class _LatihanNavigasidanbottonState extends State<LatihanNavigasidanbotton> {
  
   final List<Map<String, String>> daftarKategori = const [
    {'no': '1', 'nama': 'Buah-buahan'},
    {'no': '2', 'nama': 'Sayuran'},
    {'no': '3', 'nama': 'Elektronik'},
    {'no': '4', 'nama': 'Pakaian Pria'},
    {'no': '5', 'nama': 'Pakaian Wanita'},
    {'no': '6', 'nama': 'Alat Tulis Kantor'},
    {'no': '7', 'nama': 'Buku & Majalah'},
    {'no': '8', 'nama': 'Peralatan Dapur'},
    {'no': '9', 'nama': 'Makanan Ringan'},
    {'no': '10', 'nama': 'Minuman'},
    {'no': '11', 'nama': 'Mainan Anak'},
    {'no': '12', 'nama': 'Peralatan Olahraga'},
    {'no': '13', 'nama': 'Produk Kesehatan'},
    {'no': '14', 'nama': 'Kosmetik'},
    {'key': '15', 'nama': 'Obat-obatan'},
    {'no': '16', 'nama': 'Aksesoris Mobil'},
    {'no': '17', 'nama': 'Perabot Rumah'},
    {'no': '18', 'nama': 'Sepatu & Sandal'},
    {'no': '19', 'nama': 'Barang Bekas'},
    {'no': '20', 'nama': 'Voucher & Tiket'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kategori'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      // 2. Implementasi ListView.builder
      body: ListView.builder(
        itemCount: daftarKategori.length,
        itemBuilder: (context, index) {
          final item = daftarKategori[index];
          
          return Container(
            // Memberikan garis pembatas bawah mirip seperti tabel
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: ListTile(
              // Menampilkan nomor di sebelah kiri dengan kotak lingkaran kecil
              leading: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blue.shade50,
                child: Text(
                  item['no'] ?? '${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              // Menampilkan Nama Kategori
              title: Text(
                item['nama'] ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Efek panah di sebelah kanan untuk mempercantik UI list
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                // Aksi ketika salah satu kategori diklik
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Anda memilih Kategori: ${item['nama']}')),
                );
              },
            ),
          );
        },
      ),
     
    );
  }
}
