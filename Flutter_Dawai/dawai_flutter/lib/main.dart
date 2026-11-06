import 'package:flutter/material.dart';

import 'core.dart';
import 'screens/auth_screens.dart';
// تم تطوير تطبيق دوائي ❤️ بواسطة فريق العمل

void main() {
  runApp(const DawaiApp());
}

class DawaiApp extends StatelessWidget {
  const DawaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dawa'i - دوائي",
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: C.purple),
      ),
      home: const SplashScreen(),
    );
  }
}