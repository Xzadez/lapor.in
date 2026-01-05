import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/laporan_screen/model/laporan_model.dart'; // Import Model
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
        child: RefreshIndicator(
          onRefresh: controller.fetchRiwayat, // Fitur Pull to Refresh
          color: const Color(0xFF35BBA4),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 12),
                const Text(
                  "Laporan Selesai & Arsip",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // --- LIST DATA (OBX) ---
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: CircularProgressIndicator(
                          color: Color(0xFF35BBA4),
                        ),
                      ),
                    );
                  }

                  if (controller.riwayatList.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: const [
                            Icon(Icons.history, size: 50, color: Colors.grey),
                            SizedBox(height: 10),
                            Text(
                              "Belum ada riwayat laporan",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Column(
                    children:
                        controller.riwayatList.map((item) {
                          return _buildRiwayatCard(item);
                        }).toList(),
                  );
                }),
              ],
            ),
          ),
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
          IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
        ],
      ),
    );
  }

  // ========================= CARD RIWAYAT =========================
  Widget _buildRiwayatCard(LaporanModel item) {
    // Tentukan Label Status & Warna secara manual
    String statusLabel = "SELESAI";
    Color statusColor = Colors.green;

    if (item.rejected) {
      statusLabel = "DITOLAK";
      statusColor = Colors.red;
    } else if (item.cancelled) {
      statusLabel = "DIBATALKAN";
      statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        // Navigasi ke Detail Laporan
        Get.toNamed(AppRoutes.detailLaporanScreen, arguments: item);
      },
      child: Container(
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
                  Text(
                    item.tanggal,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    item.judul, // Judul sudah dipotong di Model
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      if (item.urgent) ...[
                        _badge("Urgent", Colors.red),
                        const SizedBox(width: 8),
                      ],
                      _badge(item.kategori, const Color(0xFF35BBA4)),
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
                      item.imageUrl,
                      height: 70,
                      width: 115,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            height: 70,
                            width: 115,
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                    ),
                  ),

                  Positioned(
                    right: 6,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(
                          0.9,
                        ), // Warna solid agar terbaca
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusLabel,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================= BADGE HELPER =========================
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
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
