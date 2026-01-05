import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Sesuaikan import screen Anda
import 'package:laporin/app/presentation/home_screen/home_screen.dart';
import 'package:laporin/app/presentation/laporan_screen/laporan_screen.dart';
import 'package:laporin/app/presentation/riwayat_screen/riwayat_screen.dart';
import 'package:laporin/app/presentation/profile_screen/profile_screen.dart';
import 'controller/main_controller.dart';
import 'components/custom_bottom_nav_bar.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: Obx(
        () => SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            onPressed: controller.onTapAddReport,
            backgroundColor: controller.themeColor,
            elevation: 4,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 32),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // --------------------------------
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          selectedIndex: controller.tabIndex.value,
          navColor: controller.themeColor,

          onItemSelected: (index) {
            controller.changeTabIndex(index);
          },
        ),
      ),
    );
  }
}
