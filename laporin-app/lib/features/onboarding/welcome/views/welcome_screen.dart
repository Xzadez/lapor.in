import 'package:flutter/material.dart';

/// VIEW - WELCOME SCREEN
/// ---------------------------------------------------
/// Scrum Master : Rafly
/// Dev Team     : Adriyan, Maulana Ziddan
/// ---------------------------------------------------

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text("Selamat Datang di Laporin", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Arahkan ke Login
              },
              child: const Text("Mulai Sekarang"),
            )
          ],
        ),
      ),
    );
  }
}
