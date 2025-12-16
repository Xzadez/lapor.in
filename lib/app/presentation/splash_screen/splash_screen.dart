import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject Controller
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white, // Sesuaikan warna background package kamu
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ganti dengan Logo Aplikasimu
            Image.asset('assets/images/logo.png', width: 150, height: 150),
            const SizedBox(height: 24),

            // Loading Indicator kecil agar user tahu aplikasi sedang bekerja
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
