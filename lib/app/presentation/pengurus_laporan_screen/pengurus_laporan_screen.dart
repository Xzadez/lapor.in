import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/pengurus_laporan_controller.dart';

class LaporanScreen extends GetView<LaporanController> {
  const LaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: const [
            _Header(),
            SizedBox(height: 8),
            _TabSection(),
            SizedBox(height: 12),
            Expanded(child: _LaporanList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF2EC4B6),
        child: const Icon(Icons.add),
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
            'Laporan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Icon(Icons.menu),
        ],
      ),
    );
  }
}
class _TabSection extends GetView<LaporanController> {
  const _TabSection();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            _TabItem(
              title: 'Laporan Warga',
              active: controller.activeTab.value == 0,
              onTap: () => controller.setTab(0),
            ),
            const SizedBox(width: 24),
            _TabItem(
              title: 'Laporanku',
              active: controller.activeTab.value == 1,
              onTap: () => controller.setTab(1),
            ),
          ],
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
              margin: const EdgeInsets.only(top: 6),
              height: 2,
              width: 32,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}
class _LaporanList extends GetView<LaporanController> {
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
    final status = _statusConfig(item.status);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
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
                Text(item.tanggal,
                    style:
                    const TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(item.judul,
                    style:
                    const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (item.urgent)
                      const _Badge('Urgent', Colors.red),
                    if (item.urgent) const SizedBox(width: 6),
                    _Badge(item.kategori, Colors.green),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.imageUrl,
                  width: 90,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 90,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: status.color.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _StatusConfig _statusConfig(LaporanStatus status) {
    switch (status) {
      case LaporanStatus.diajukan:
        return const _StatusConfig('Diajukan', Colors.orange);
      case LaporanStatus.diterima:
        return const _StatusConfig('Diterima', Colors.green);
      case LaporanStatus.ditolak:
        return const _StatusConfig('Ditolak', Colors.red);
      case LaporanStatus.diproses:
        return const _StatusConfig('Diproses', Colors.blue);
    }
  }
}

class _StatusConfig {
  final String label;
  final Color color;

  const _StatusConfig(this.label, this.color);
}
class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, color: color),
      ),
    );
  }
}

class _BottomNav extends GetView<LaporanController> {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFF2EC4B6),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(Icons.home, 'Beranda',
                active: controller.bottomNavIndex.value == 0,
                onTap: () => controller.setBottomNav(0)),
            _NavItem(Icons.description, 'Laporan',
                active: controller.bottomNavIndex.value == 1,
                onTap: () => controller.setBottomNav(1)),
            _NavItem(Icons.history, 'Riwayat',
                active: controller.bottomNavIndex.value == 2,
                onTap: () => controller.setBottomNav(2)),
            _NavItem(Icons.person, 'Akun',
                active: controller.bottomNavIndex.value == 3,
                onTap: () => controller.setBottomNav(3)),
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

  const _NavItem(this.icon, this.label,
      {required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? Colors.white : Colors.white70),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 10,
                  color: active ? Colors.white : Colors.white70)),
        ],
      ),
    );
  }
}
