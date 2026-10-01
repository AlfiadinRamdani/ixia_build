import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ixia_build/tugas15/views/splash15.dart';
import 'package:ixia_build/tugas15/services/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Absensi PPKD',
          theme: themeProvider.themeData,
          home: const Splash15(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
