import 'package:flutter/material.dart';

class LatihanBottonnavigator extends StatefulWidget {
  const LatihanBottonnavigator({super.key});

  @override
  State<LatihanBottonnavigator> createState() => _LatihanBottonnavigatorState();
}

class _LatihanBottonnavigatorState extends State<LatihanBottonnavigator> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Center(
      child: Text('Halaman Beranda 1', style: TextStyle(fontSize: 24)),
    ),
    const Center(child: Text('Halaman Cari 2', style: TextStyle(fontSize: 24))),
    const Center(
      child: Text('Halaman Profil 3', style: TextStyle(fontSize: 24)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latihan Bottom Navigator'),
        backgroundColor: const Color.fromARGB(255, 236, 12, 12),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
