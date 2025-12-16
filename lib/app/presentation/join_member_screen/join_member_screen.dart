import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/join_member_screen/controller/join_member_controller.dart';

class JoinMemberScreen extends GetView<JoinMemberController> {
  const JoinMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna primary biru aplikasi
    final Color primaryColor = const Color(0xFF1E88E5);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5F5F5,
      ), // Background abu muda agar Card terlihat pop-up
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Gabung Komunitas RT/RW",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tentukan cara Anda terhubung",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Silahkan pilih salah satu metode verifikasi di bawah ini untuk masuk ke komunitas RT/RW Anda.",
              style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 24),

            // --- KARTU 1: SCAN QR ---
            _buildSelectionCard(
              icon: Icons.qr_code_scanner_rounded,
              title: "Pindai Kode QR",
              description:
                  "Cara praktis! Cukup arahkan kamera Anda ke kode QR yang ditempel di posko atau diberikan oleh Ketua RT.",
              onTap: controller.onTapScanQR,
              primaryColor: primaryColor,
            ),

            const SizedBox(height: 16),

            // --- KARTU 2: INPUT KODE MANUAL ---
            _buildSelectionCard(
              icon: Icons.keyboard_alt_rounded, // Icon keyboard/input
              title: "Masukkan Token Manual",
              description:
                  "Tidak bisa scan? Ketik kode unik member secara manual untuk bergabung.",
              onTap: controller.onTapInputCode,
              primaryColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    required Color primaryColor,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start, // Icon tetap di atas jika teks panjang
            children: [
              // Bagian Icon Besar di Kiri
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  // Biar tidak polos putih, kasih background tipis
                  color: Colors.white,
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Colors.black87),
              ),
              const SizedBox(width: 16),

              // Bagian Teks di Kanan
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900], // Biru gelap agar elegan
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
