import 'package:chat_app/core/theme/light_mode.dart';
import 'package:chat_app/features/login/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: LoginPage(),
    );
  }
}
