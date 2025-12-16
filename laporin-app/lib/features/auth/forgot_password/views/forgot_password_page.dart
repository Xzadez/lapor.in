import 'package:flutter/material.dart';

/// VIEW - FORGOT PASSWORD
/// ---------------------------------------------------
/// Product Owner : Maulana Ziddan
/// Dev Team      : Rachmat Mauluddin, Rafly
/// ---------------------------------------------------

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lupa Password")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Masukkan email Anda untuk reset password"),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic reset
              },
              child: const Text("Kirim Link Reset"),
            )
          ],
        ),
      ),
    );
  }
}
