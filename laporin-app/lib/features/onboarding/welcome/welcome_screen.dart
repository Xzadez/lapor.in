import 'package:flutter/material.dart';

/// FITUR: Welcome Screen
/// ---------------------------------------------------
/// Product Owner : -
/// Scrum Master  : Rafly
/// Developer     : Adriyan, Maulana Ziddan
/// ---------------------------------------------------

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Selamat Datang di Laporin")),
    );
  }
}
