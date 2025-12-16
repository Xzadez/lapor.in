// FILE: lib/features/auth/login/views/login_page.dart
import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';

/// VIEW (UI TAMPILAN)
/// ---------------------------------------------------
/// Dev Team    : Rafly (UI Slicing)
/// Scrum Master: Maulana Ziddan
/// Deskripsi   : Halaman tatap muka user
/// ---------------------------------------------------

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Inisialisasi Controller
  final LoginController _controller = LoginController();
  
  // Controller untuk Text Field
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Masuk Laporin"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo atau Judul
            const Icon(Icons.lock_person, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 20),
            
            // Input Email
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),

            // Input Password
            TextField(
              controller: _passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Login dengan State Loading
            // Menggunakan ValueListenableBuilder agar hanya tombol yang berubah saat loading
            ValueListenableBuilder<bool>(
              valueListenable: _controller.isLoading,
              builder: (context, isLoading, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null // Matikan tombol saat loading
                        : () {
                            // Panggil fungsi di Controller
                            _controller.login(
                              context, 
                              _emailCtrl.text, 
                              _passCtrl.text
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Arahkan ke halaman Forgot Password
              },
              child: const Text("Lupa Password?"),
            )
          ],
        ),
      ),
    );
  }
}
