import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/home_screen/home_screen.dart';
import 'package:laporin/app/presentation/laporan_screen/laporan_screen.dart';
import 'package:laporin/app/presentation/profile_screen/profile_screen.dart';
import 'package:laporin/app/presentation/riwayat_screen/riwayat_screen.dart';
import 'controller/main_controller.dart';
import 'components/custom_bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();

    return Scaffold(
      // Extend body agar background curve menyatu dengan halaman
      extendBody: true,

      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: const [
            HomeScreen(),
            LaporanScreen(),
            RiwayatScreen(),
            ProfileScreen(),
          ],
        ),
      ),

      // Panggil Widget Navbar yang sudah kita pisah
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          selectedIndex: controller.tabIndex.value,
          onItemSelected: (index) {
            controller.changeTabIndex(index);
          },
        ),
      ),
    );
  }
}
