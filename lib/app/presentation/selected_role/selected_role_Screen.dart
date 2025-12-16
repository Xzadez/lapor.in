import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/selected_role_controller.dart';

class SelectedRoleView extends GetView<SelectedRoleController> {
  const SelectedRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna tema aplikasi (Biru)
    final Color primaryColor = const Color(0xFF1E88E5);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Background agak abu terang
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Pilih Peran', // Atau "Opsi Berlangganan" sesuai kebutuhan
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: controller.onSkip,
            child: const Text("Lewati", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // --- KARTU 1: BERGABUNG ---
            _buildRoleCard(
              title: "Bergabung menjadi warga baru di RT/RW",
              description: "Bergabung untuk menjadi warga baru",
              buttonText: "GABUNG SEKARANG",
              primaryColor: primaryColor,
              onTap: controller.onJoinMember,
              isPlaceholder: true, // Ubah false jika sudah ada gambar aset
            ),

            const SizedBox(height: 20),

            // --- KARTU 2: BUAT BARU ---
            _buildRoleCard(
              title: "Buat RT/RW",
              description:
                  "Baru install aplikasi? Yuk buat Komunitas RT/RW baru!!.",
              buttonText: "BUAT KOMUNITAS SEKARANG",
              primaryColor: primaryColor,
              onTap: controller.onCreateCommunity,
              isPlaceholder: true,
            ),
          ],
        ),
      ),
    );
  }

  // ================= WIDGET CARD REUSABLE =================
  Widget _buildRoleCard({
    required String title,
    required String description,
    required String buttonText,
    required Color primaryColor,
    required VoidCallback onTap,
    bool isPlaceholder = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- GAMBAR HEADER (Placeholder Silang) ---
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                // Garis Silang tipis ala mockup/wireframe
                Center(
                  child: CustomPaint(
                    size: const Size(double.infinity, 150),
                    painter: CrossLinePainter(),
                  ),
                ),
                // Icon Center (Opsional)
                const Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 40,
                    color: Colors.black12,
                  ),
                ),
              ],
            ),
          ),

          // --- KONTEN TEXT ---
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900], // Biru gelap untuk judul
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // --- TOMBOL ---
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor, // Warna BIRU Aplikasi
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Painter untuk membuat garis silang (X) background gambar seperti di mockup
class CrossLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black12
          ..strokeWidth = 1;

    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
