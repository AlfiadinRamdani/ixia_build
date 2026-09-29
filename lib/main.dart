import 'package:flutter/material.dart';
import 'package:ixia_build/tugas11/splash_screen11.dart';
import 'package:ixia_build/tugas13/list_user13.dart';
import 'package:ixia_build/tugas15/views/login_pages15.dart';
import 'package:ixia_build/tugas15/views/profil_screen15.dart';

import 'package:ixia_build/tugas15/views/register_screen15.dart';
import 'package:ixia_build/tugas15/views/splash15.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 110, 183, 58),
        ),
      ),
      home: const Splash15(),
    );
  }
}
