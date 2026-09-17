import 'package:flutter/material.dart';
import 'package:ixia_build/pages/latiahan_datepicker.dart';

import 'package:ixia_build/pages/latihan_dropdown.dart';
import 'package:ixia_build/pages/latihan_switch.dart';
import 'package:ixia_build/pages/latihan_timepickter.dart';

import 'package:ixia_build/pages/tugas_skemadesian.dart';

class Tugas8 extends StatefulWidget {
  const Tugas8({super.key});

  @override
  State<Tugas8> createState() => _LatihanDrawerState();
}

class _LatihanDrawerState extends State<Tugas8> {
  int _currentIndex = 0;
  int _selectedIndex = 0;
  final List<String> _titles = [
    'latihan Checkbox',
    'latihan switch',
    'latihan dropdown',
    'latihan datapicker',
    'latihan timepicker',
  ];
  final List<Widget> _drawerPages = [
    const TugasSkemadesian(),
    const LatihanSwitch(),
    const LatihanDropdown(),
    const LatiahanDatepicker(),
    const LatihanTimepickter(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: const Color(0xE80202EB),
      ),

      body: _drawerPages[_selectedIndex],

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Budi Setiawan'),
              accountEmail: Text('budi.setiawan@email.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0XFFEEEEEE),
                child: Text(
                  'B',
                  style: TextStyle(fontSize: 40.0, color: Colors.blue),
                ),
              ),
              decoration: BoxDecoration(color: Color(0xFF0717FF)),
            ),
            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text('Latihan Checkbox'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contrast),
              title: const Text('Latihan switch'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_drop_down),
              title: const Text('Latihan Dropdown'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Latihan Datepicker'),
              selected: _selectedIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Latihan Datepicker'),
              selected: _selectedIndex == 4,
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
