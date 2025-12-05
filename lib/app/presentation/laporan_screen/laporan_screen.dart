import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../laporan_screen/controller/laporan_controller.dart';
import '../laporan_screen/view/laporan_model.dart';

class LaporanScreen extends StatelessWidget {
  const LaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LaporanController>();

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
                  const SizedBox(height: 16),

                  Obx(() {
                    return Column(
                      children: controller.laporanList
                          .map((laporan) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildLaporanCard(laporan),
                      ))
                          .toList(),
                    );
                  }),

                  const SizedBox(height: 120),
                ],
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNav(),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 32),
          const Spacer(),
          const Text(
            'Laporan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // ================= CARD =================
  Widget _buildLaporanCard(LaporanModel data) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                data.tanggal,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const Spacer(),
              if (data.rejected)
                const Text(
                  "Ditolak",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                )
              else if (data.estimasi != null)
                Text(
                  data.estimasi!,
                  style: const TextStyle(
                      fontSize: 10, color: Colors.black54),
                ),
              const SizedBox(width: 6),
              const Icon(Icons.more_horiz, size: 18),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            data.judul,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              if (data.urgent) _buildBadge("Urgent", Colors.red),
              const SizedBox(width: 8),
              _buildBadge(data.kategori, Colors.green),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              data.imageUrl,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 14),

          _buildStepProgress(data.statusIndex),

          if (!data.rejected && data.statusIndex < 3) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Batalkan"),
              ),
            ),
          ]
        ],
      ),
    );
  }

  // ================= BADGE =================
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

  // ================= PROGRESS BAR =================
  Widget _buildStepProgress(int activeIndex) {
    final steps = ["Diajukan", "Diterima", "Diproses", "Selesai"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (i) {
        final isActive = i == activeIndex;

        return Column(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: isActive ? Colors.red : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
            ),
            const SizedBox(height: 6),
            Text(steps[i], style: const TextStyle(fontSize: 10)),
          ],
        );
      }),
    );
  }

  // ================= NAVBAR (KONSISTEN) =================
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
          _navItem(
            icon: Icons.home,
            label: "Beranda",
            onTap: () => Get.back(),
          ),
          _navItem(
            icon: Icons.assignment_outlined,
            label: "Laporan",
            isActive: true,
            onTap: () {},
          ),
          _navItem(
            icon: Icons.history,
            label: "Riwayat",
            onTap: () {},
          ),
          _navItem(
            icon: Icons.person,
            label: "Profile",
            onTap: () => Get.toNamed(AppRoutes.profileScreen),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 22,
              color: isActive ? const Color(0xFF1E88E5) : Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}
