import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/profile_controller.dart';
import '../../routes/app_routes.dart'; // Pastikan AppRoutes tersedia

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final user = controller.user;

        return Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade300,
                          child: user['photoUrl'] == null
                              ? const Icon(Icons.person, size: 40, color: Colors.white)
                              : null,
                          // Jika ada URL foto:
                          // backgroundImage: NetworkImage(user['photoUrl']),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'] ?? 'Nama tidak tersedia',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user['email'] ?? 'Email tidak tersedia',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: Text(user['email'] ?? 'Email tidak tersedia'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: controller.logout,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            // Bottom navigation bar with bottom gap
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNav(context),
            ),
          ],
        );
      }),
    );
  }

  // ========================= Bottom Navigation =========================
  Widget _buildBottomNav(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 8), // 👈 Tambahkan jarak bawah
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
          _buildNavItem(
            icon: Icons.home,
            label: 'Beranda',
            onTap: () => Get.toNamed(AppRoutes.homeScreen),
          ),
          _buildNavItem(
            icon: Icons.assignment_outlined,
            label: 'Laporan',
            onTap: () => Get.snackbar('Info', 'Halaman Laporan belum dibuat'),
          ),
          _buildNavItem(
            icon: Icons.history,
            label: 'Riwayat',
            onTap: () => Get.snackbar('Info', 'Halaman Riwayat belum dibuat'),
          ),
          _buildNavItem(
            icon: Icons.person,
            label: 'Profil',
            isActive: true,
            onTap: () {}, // sudah di halaman ini
          ),
        ],
      ),
    );
  }

  // ========================= Nav Item Widget =========================
  Widget _buildNavItem({
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
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
