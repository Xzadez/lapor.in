import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WelcomeController>();
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFABBBD3),
              Color(0xFF5981B5),
            ],
          ),
        ),
        child: Stack(
          children: [
            // LOGO ANIMATION
            Obx(() {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutQuart,
                top: controller.animationStarted.value ? height * 0.28 : -120,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png', // pastikan file dimasukkan ke assets
                    height: 110,
                  ),
                ),
              );
            }),

            // TEXTS
            Positioned(
              top: height * 0.42,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Lapor.in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Laporkan dengan mudah, pantau dengan pasti",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // BUTTON MULAI
            Positioned(
              bottom: 80,
              left: 24,
              right: 24,
              child: TextButton(
                onPressed: () {
                  Get.toNamed('/login_screen');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.white.withOpacity(0.15), // Putih transparan Figma
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.white), // Border putih
                  ),
                  foregroundColor: Colors.white, // warna teks
                ).copyWith(
                  overlayColor: MaterialStateProperty.all(
                    Colors.white.withOpacity(0.25), // Efek klik halus, tidak abu-abu
                  ),
                ),
                child: const Text(
                  "Mulai",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
