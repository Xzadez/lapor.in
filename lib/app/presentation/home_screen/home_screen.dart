import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Stack(
        children: [
          // ===================== SCROLL CONTENT (SAFE AREA) =====================
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildCarousel(controller, width),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      "Silahkan klik ikon '+' untuk tambah laporan",
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTambahLaporanBox(),
                  const SizedBox(height: 24),

                  const Text(
                    "Berita Terkini",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),
                  _buildBeritaTerkiniCard(),
                ],
              ),
            ),
          ),

          // ===================== FLOATING BUBBLE =====================
          Positioned(
            bottom: 20,
            right: 16,
            child: Column(
              children: [
                _roundIconButton(
                  Icons.mic,
                  tooltip: 'Aktifkan perintah suara?',
                ),
                const SizedBox(height: 12),
                _roundIconButton(
                  Icons.text_increase,
                  tooltip: 'Ganti ukuran huruf?',
                ),
              ],
            ),
          ),
        ],
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
  Widget _buildBeritaTerkiniCard() {
    return Container(
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
          const Text(
            "20 Oktober 2025",
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 4),

          const Text(
            "Judul Laporan",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),
          Row(
            children: [
              _buildBadge("Urgent", Colors.red),
              const SizedBox(width: 8),
              _buildBadge("Kategori", Colors.green),
            ],
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // ========================= BADGE =========================
  Widget _buildBadge(String text, Color color) {
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
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ========================= FLOATING BUBBLE =========================
  static Widget _roundIconButton(
    IconData icon, {
    double size = 40,
    String? tooltip,
  }) {
    final button = Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: size * 0.55, color: Color(0xFF1E88E5)),
    );

    return tooltip != null ? Tooltip(message: tooltip, child: button) : button;
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
