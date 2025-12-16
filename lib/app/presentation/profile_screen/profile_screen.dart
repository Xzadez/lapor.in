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

        return SafeArea(
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
                      child:
                          user['photoUrl'] == null
                              ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              )
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
        );
      }),
    );
  }

  // ========================= Bottom Navigation =========================
}
