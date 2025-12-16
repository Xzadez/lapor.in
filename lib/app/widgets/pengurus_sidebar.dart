import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengurusSidebar extends StatelessWidget {
  const PengurusSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2F6DB3),
              Color(0xFF1E4F8F),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 24),
              _menuItem(
                icon: Icons.person_outline,
                title: 'Profil',
                onTap: () {
                  Get.back();
                  // Get.toNamed(AppRoutes.profileScreen);
                },
              ),
              _menuItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  Get.back();
                  _confirmLogout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.location_on,
              color: Color(0xFF2F6DB3),
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Lapor.in',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Apakah Anda yakin ingin logout?',
      textCancel: 'Batal',
      textConfirm: 'Logout',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        // Get.offAllNamed(AppRoutes.loginScreen);
      },
    );
  }
}