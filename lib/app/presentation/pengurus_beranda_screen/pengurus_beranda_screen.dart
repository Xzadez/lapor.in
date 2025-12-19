import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/pengurus_beranda_controller.dart';

class PengurusBerandaScreen extends GetView<PengurusBerandaController> {
  const PengurusBerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: const [
            _Header(),
            SizedBox(height: 16),
            _LaporanTerbaru(),
            SizedBox(height: 12),
            _TabSection(),
            SizedBox(height: 8),
            Expanded(child: _LaporanList()),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNav(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          SizedBox(width: 24),
          Text(
            'Beranda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(Icons.menu),
        ],
      ),
    );
  }
}

class _LaporanTerbaru extends GetView<PengurusBerandaController> {
  const _LaporanTerbaru();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Laporan Terbaru',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 160,
          child: Obx(
                () => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: controller.bannerImages.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final imageUrl = controller.bannerImages[index];
                return _BannerCard(
                  imageUrl: imageUrl,
                  title: 'Judul Laporan',
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const _BannerCard({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported),
            ),
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabSection extends GetView<PengurusBerandaController> {
  const _TabSection();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: List.generate(
            controller.tabs.length,
                (index) => Padding(
              padding: EdgeInsets.only(right: index == 2 ? 0 : 20),
              child: _TabItem(
                title: controller.tabs[index],
                active: controller.activeTabIndex.value == index,
                onTap: () => controller.setActiveTab(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool active;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (active)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: 20,
                color: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}

class _LaporanList extends GetView<PengurusBerandaController> {
  const _LaporanList();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: controller.laporan.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = controller.laporan[index];
          return _LaporanCard(item: item);
        },
      ),
    );
  }
}

class _LaporanCard extends StatelessWidget {
  final LaporanItem item;

  const _LaporanCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.tanggal,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.judul,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (item.urgent) const _Badge('Urgent', Colors.red),
                    if (item.urgent) const SizedBox(width: 6),
                    _Badge(item.kategori, Colors.green),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 90,
              height: 60,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported, size: 18),
                ),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
        ),
      ),
    );
  }
}

class _BottomNav extends GetView<PengurusBerandaController> {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFF2EC4B6),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home,
              label: 'Beranda',
              active: controller.bottomNavIndex.value == 0,
              onTap: () => controller.setBottomNav(0),
            ),
            _NavItem(
              icon: Icons.description,
              label: 'Laporan',
              active: controller.bottomNavIndex.value == 1,
              onTap: () => controller.setBottomNav(1),
            ),
            _NavItem(
              icon: Icons.history,
              label: 'Riwayat',
              active: controller.bottomNavIndex.value == 2,
              onTap: () => controller.setBottomNav(2),
            ),
            _NavItem(
              icon: Icons.person,
              label: 'Akun',
              active: controller.bottomNavIndex.value == 3,
              onTap: () => controller.setBottomNav(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? Colors.white : Colors.white70),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: active ? Colors.white : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
