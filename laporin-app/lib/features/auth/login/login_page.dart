import 'package:flutter/material.dart';

/// FITUR: Login Page
/// ---------------------------------------------------
/// Product Owner : -
/// Scrum Master  : Maulana Ziddan
/// Developer     : Rachmat Mauluddin, Rafly
/// ---------------------------------------------------

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Laporin")),
      body: const Center(child: Text("Form Login di sini")),
    );
  }
}
