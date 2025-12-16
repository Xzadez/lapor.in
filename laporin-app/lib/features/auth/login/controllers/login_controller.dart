// FILE: lib/features/auth/login/controllers/login_controller.dart
import 'dart:async'; // Simulasi delay API
import 'package:flutter/material.dart';
import '../models/login_request_model.dart';

/// CONTROLLER (LOGIC)
/// ---------------------------------------------------
/// Scrum Master: Maulana Ziddan (Reviewer)
/// Dev Team    : Rachmat Mauluddin (Logic Implementation)
/// Deskripsi   : Mengatur logika validasi dan proses login
/// ---------------------------------------------------

class LoginController {
  // Status loading agar UI tahu kapan harus munculkan spinner
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Fungsi utama login
  Future<void> login(BuildContext context, String email, String password) async {
    // 1. Validasi Input Sederhana
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan Password tidak boleh kosong!")),
      );
      return;
    }

    // 2. Mulai Loading
    isLoading.value = true;

    // 3. Bungkus data ke dalam Model
    LoginRequestModel requestData = LoginRequestModel(
      email: email, 
      password: password
    );
    
    print("Mengirim data ke server: ${requestData.toJson()}");

    // 4. Simulasi Panggil API (Delay 2 detik)
    await Future.delayed(const Duration(seconds: 2));

    // 5. Selesai Loading
    isLoading.value = false;

    // 6. Cek Hasil (Simulasi)
    if (email == "admin@laporin.com" && password == "123456") {
      // JIKA SUKSES
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.green, content: Text("Login Berhasil!")),
        );
        // Navigasi ke Home Screen (Contoh)
        // Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      // JIKA GAGAL
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.red, content: Text("Email atau Password Salah!")),
        );
      }
    }
  }
}
