import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/pengurus_detail_controller.dart';

class DetailLaporanScreen
    extends GetView<DetailLaporanController> {
  const DetailLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _ImageSection(),
                    SizedBox(height: 12),
                    _BadgeSection(),
                    SizedBox(height: 12),
                    _TitleSection(),
                    SizedBox(height: 16),
                    _DescriptionSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomAction(),
    );
  }
}
class _Header extends GetView<DetailLaporanController> {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: controller.onBack,
            icon: const Icon(Icons.arrow_back),
          ),
          const Expanded(
            child: Text(
              'Detail Laporan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
class _ImageSection extends GetView<DetailLaporanController> {
  const _ImageSection();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        controller.imageUrl,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
class _BadgeSection extends StatelessWidget {
  const _BadgeSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _Badge('Urgent', Colors.red),
        SizedBox(width: 8),
        _Badge('Kategori', Colors.green),
      ],
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
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
class _TitleSection extends GetView<DetailLaporanController> {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.judul,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${controller.tanggal} • ${controller.waktu}',
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
class _DescriptionSection
    extends GetView<DetailLaporanController> {
  const _DescriptionSection();

  @override
  Widget build(BuildContext context) {
    return Text(
      controller.deskripsi,
      style: const TextStyle(
        fontSize: 13,
        height: 1.5,
        color: Colors.black87,
      ),
    );
  }
}
class _BottomAction extends GetView<DetailLaporanController> {
  const _BottomAction();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton(
          onPressed: controller.onRespon,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2EC4B6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text(
            'RESPON',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
