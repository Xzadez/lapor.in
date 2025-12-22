import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.userProfile;
        // Logic untuk menu akses (Data Pengurus) tetap dibatasi
        final bool showPrivilegedMenu = controller.isAdminOrPengurus;

        // Ambil text untuk ditampilkan
        final String roleText = user['role_display'] ?? 'Warga';

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // --- FOTO PROFIL ---
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 16),

                // --- NAMA & EMAIL ---
                Text(
                  user['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user['email'] ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),

                // --- BADGE ROLE (TAMPIL UNTUK SEMUA) ---
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getRoleColor(roleText), // Warna dinamis
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    roleText, // "Pengurus" atau "Warga"
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                const Divider(),

                // --- MENU KHUSUS PENGURUS/ADMIN ---
                // Hanya Admin/Ketua yang bisa lihat menu kelola pengurus
                if (showPrivilegedMenu) ...[
                  _buildMenuTile(
                    icon: Icons.people_alt_rounded,
                    title: "Data Pengurus",
                    subtitle: "Kelola daftar pengurus RT/RW",
                    onTap: () {
                      Get.snackbar(
                        "Info",
                        "Fitur Kelola Pengurus akan segera hadir",
                      );
                    },
                    isHighlight: true,
                  ),
                  const Divider(),
                ],

                // --- DETAIL INFORMASI ---
                _buildInfoTile(
                  icon: Icons.admin_panel_settings,
                  title: "Status Peran",
                  value: roleText,
                ),
                _buildInfoTile(
                  icon: Icons.home_work,
                  title: "Komunitas / Lingkungan",
                  value: user['community_name'] ?? '-',
                ),
                _buildInfoTile(
                  icon: Icons.cake,
                  title: "Tanggal Lahir",
                  value: user['birth_day'] ?? '-',
                ),
                _buildInfoTile(
                  icon: Icons.email_outlined,
                  title: "Email Terdaftar",
                  value: user['email'] ?? '-',
                ),

                const SizedBox(height: 40),

                // --- TOMBOL LOGOUT ---
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: controller.logout,
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Helper Warna Badge
  Color _getRoleColor(String roleDisplay) {
    if (roleDisplay == 'Pengurus') {
      return const Color(0xFF35BBA4); // Hijau Tosca
    }
    // Default Warga
    return Colors.blue;
  }

  // Widget Helper (Info Tile & Menu Tile) - Tetap sama
  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue.shade700, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isHighlight = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isHighlight ? const Color(0xFFE0F2F1) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isHighlight ? const Color(0xFF35BBA4) : Colors.blue.shade700,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
    );
  }
}
