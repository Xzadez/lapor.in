import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../riwayat_screen/controller/riwayat_controller.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RiwayatController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 12),

                  const Text(
                    "Laporan anda",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Obx(() {
                    return Column(
                      children: controller.riwayatList.map((item) {
                        return _buildRiwayatCard(item);
                      }).toList(),
                    );
                  }),

                  const SizedBox(height: 550), // supaya tidak ketutup navbar
                ],
              ),
            ),

            // ================= BOTTOM NAV =================
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNav(),
            )
          ],
        ),
      ),
    );
  }

  // ========================= HEADER =========================
  Widget _buildHeader() {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 32),
          const Spacer(),
          const Text(
            "Riwayat",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  // ========================= CARD RIWAYAT =========================
  Widget _buildRiwayatCard(item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =============== LEFT SIDE (TEXT) ===============
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.tanggal,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 4),

                Text(item.judul,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                Row(
                  children: [
                    _badge(item.urgensi, Colors.red),
                    const SizedBox(width: 8),
                    _badge(item.kategori, Colors.green),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // =============== RIGHT SIDE (IMAGE + STATUS) ===============
          SizedBox(
            width: 115,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.gambar,
                    height: 70,
                    width: 115,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  right: 6,
                  top: 4,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _statusColor(item.status).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.status,
                      style: TextStyle(
                        fontSize: 10,
                        color: _statusColor(item.status),
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

  // ========================= STATUS COLOR =========================
  Color _statusColor(String status) {
    switch (status) {
      case "Proses":
        return Colors.green;
      case "Ditolak":
        return Colors.red;
      case "Selesai":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // ========================= BADGE =========================
  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ========================= NAVBAR =========================
  Widget _buildBottomNav() {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Color(0xFF1E88E5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _nav(Icons.home, "Beranda",
                  () => Get.toNamed(AppRoutes.homeScreen)),
          _nav(Icons.assignment_outlined, "Laporan",
                  () => Get.toNamed(AppRoutes.laporanScreen)),
          _nav(Icons.history, "Riwayat", () {},
              active: true),
          _nav(Icons.person, "Profile",
                  () => Get.toNamed(AppRoutes.profileScreen)),
        ],
      ),
    );
  }

  Widget _nav(IconData icon, String label, VoidCallback onTap,
      {bool active = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: active ? Colors.white : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 22,
              color: active ? const Color(0xFF1E88E5) : Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          )
        ],
      ),
    );
  }
}
