import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/pengurus_beranda_controller.dart';

class PengurusBerandaScreen extends GetView<PengurusBerandaController> {
  const PengurusBerandaScreen({super.key});

  static const Color primaryColor = Color(0xFF35BCA5);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 16),
                  _carousel(width),
                  const SizedBox(height: 24),
                  _infoBox(),
                  const SizedBox(height: 24),
                  const Text(
                    'Berita Terkini',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _newsCard(),
                  const SizedBox(height: 140),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _bottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: const [
        Text(
          'Beranda Pengurus',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _carousel(double width) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          width: width,
          child: PageView.builder(
            itemCount: controller.sliderImages.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (_, i) => ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                controller.sliderImages[i],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.sliderImages.length,
                (i) => Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: controller.currentPage.value == i
                        ? primaryColor
                        : primaryColor.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _infoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor),
      ),
      child: const Center(
        child: Text('Kelola laporan & pantau aktivitas warga'),
      ),
    );
  }

  Widget _newsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: const Text('Judul Berita Pengurus'),
    );
  }

  Widget _bottomNav() {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.assignment, color: Colors.white),
          Icon(Icons.history, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
      ),
    );
  }
}
