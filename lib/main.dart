import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MeshLinkApp());
}

class MeshLinkApp extends StatelessWidget {
  const MeshLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeshLink',
      theme: ThemeData(
        primaryColor: const Color(0xFF2563EB),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}