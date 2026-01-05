import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/laporan_screen/model/laporan_model.dart'; // Import Model
import '../../routes/app_routes.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.fetchLaporanTerkini, // Tarik untuk refresh data
          color: const Color(0xFF35BBA4),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildCarousel(controller, width),
                const SizedBox(height: 16),
                // --- HEADER SECTION LAPORAN TERKINI ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Laporan Terkini", // Ganti Judul
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Status: Selesai",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // --- LIST LAPORAN TERKINI (OBX) ---
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFF35BBA4),
                        ),
                      ),
                    );
                  }

                  if (controller.laporanTerkini.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.grey,
                            size: 40,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Belum ada laporan selesai.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children:
                        controller.laporanTerkini.map((laporan) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildLaporanTerkiniCard(laporan),
                          );
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
          Image.asset('assets/images/logo.png', height: 32, width: 32),
          const Spacer(),
          const Text(
            'Beranda',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ],
      ),
    );
  }

  // ========================= CAROUSEL =========================
  Widget _buildCarousel(HomeController controller, double width) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: PageView.builder(
              itemCount: controller.sliderImages.length,
              controller: PageController(viewportFraction: 0.9),
              onPageChanged: controller.onPageChanged,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Image.network(
                    controller.sliderImages[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.sliderImages.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: controller.currentPage.value == index ? 8 : 6,
                height: controller.currentPage.value == index ? 8 : 6,
                decoration: BoxDecoration(
                  color:
                      controller.currentPage.value == index
                          ? Colors.black87
                          : Colors.black26,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ========================= TAMBAH LAPORAN =========================
  Widget _buildTambahLaporanBox() {
    return Center(
      child: SizedBox(
        width: 180,
        height: 180,
        child: CustomPaint(
          painter: DashedRectPainter(
            color: Colors.black45,
            strokeWidth: 1.2,
            dashLength: 6,
            gap: 6,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add, size: 32, color: Colors.black54),
                SizedBox(height: 8),
                Text("Tambah Laporan", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========================= BERITA TERKINI CARD =========================
  Widget _buildLaporanTerkiniCard(LaporanModel data) {
    return GestureDetector(
      onTap: () {
        // Klik untuk lihat detail
        Get.toNamed(AppRoutes.detailLaporanScreen, arguments: data);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tanggal
            Text(
              data.tanggal,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 6),

            // Judul (Deskripsi Singkat)
            Text(
              data.judul,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Baris Badge
            Row(
              children: [
                // 1. Badge URGENT (Prioritas)
                if (data.urgent) ...[
                  _buildBadge("URGENT", Colors.red),
                  const SizedBox(width: 8),
                ],

                // 2. Badge Kategori
                _buildBadge(data.kategori, const Color(0xFF35BBA4)),

                const Spacer(),

                // 3. Indikator Selesai
                Row(
                  children: const [
                    Icon(Icons.check_circle, size: 16, color: Colors.blue),
                    SizedBox(width: 4),
                    Text(
                      "Selesai",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper Badge
  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ========================= DASHED BORDER =========================
class DashedRectPainter extends CustomPainter {
  DashedRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.dashLength,
  });

  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            const Radius.circular(16),
          ),
        );

    final dashed = Path();
    double distance = 0.0;

    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final next = distance + dashLength;
        dashed.addPath(metric.extractPath(distance, next), Offset.zero);
        distance = next + gap;
      }
      distance = 0.0;
    }

    canvas.drawPath(dashed, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
