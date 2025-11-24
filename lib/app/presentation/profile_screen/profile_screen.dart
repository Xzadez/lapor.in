import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/profile_controller.dart';

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
                          // backgroundImage: user['photoUrl'] != null
                          //     ? NetworkImage(user['photoUrl'])
                          //     : null,
                          backgroundColor: Colors.grey.shade300,
                          child: user['photoUrl'] == null
                              ? const Icon(Icons.person, size: 40, color: Colors.white)
                              : null,
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

            Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 80),
                painter: BottomNavPainterRight(),
                child: SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home_outlined, "Beranda"),
                      _buildNavItem(Icons.assignment_outlined, "Laporan"),
                      _buildNavItem(Icons.history, "Riwayat"),
                      _buildActiveNavItem(Icons.person, "Profil"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildActiveNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 5),
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Color(0xFF1E88E5), size: 28),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

class BottomNavPainterRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E88E5)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.71, 0);
    path.quadraticBezierTo(size.width * 0.78, 0, size.width * 0.78, 14);
    path.arcToPoint(
      Offset(size.width * 0.96, 14),
      radius: const Radius.circular(16),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.98, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
