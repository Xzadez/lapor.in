import 'package:get/get.dart';

enum LaporanStatus {
  diajukan,
  diterima,
  ditolak,
  diproses,
}

class LaporanItem {
  final String tanggal;
  final String judul;
  final bool urgent;
  final String kategori;
  final LaporanStatus status;
  final String imageUrl;

  const LaporanItem({
    required this.tanggal,
    required this.judul,
    required this.urgent,
    required this.kategori,
    required this.status,
    required this.imageUrl,
  });
}

class LaporanController extends GetxController {
  /// 0 = Laporan Warga, 1 = Laporanku
  final RxInt activeTab = 0.obs;

  /// Bottom nav index (konsisten)
  final RxInt bottomNavIndex = 1.obs;

  final RxList<LaporanItem> laporan = <LaporanItem>[
    const LaporanItem(
      tanggal: '20 Oktober 2025',
      judul: 'Judul Laporan',
      urgent: true,
      kategori: 'Kategori',
      status: LaporanStatus.diajukan,
      imageUrl:
      'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200',
    ),
    const LaporanItem(
      tanggal: '20 Oktober 2025',
      judul: 'Judul Laporan',
      urgent: true,
      kategori: 'Kategori',
      status: LaporanStatus.diterima,
      imageUrl:
      'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200',
    ),
    const LaporanItem(
      tanggal: '20 Oktober 2025',
      judul: 'Judul Laporan',
      urgent: true,
      kategori: 'Kategori',
      status: LaporanStatus.ditolak,
      imageUrl:
      'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200',
    ),
    const LaporanItem(
      tanggal: '20 Oktober 2025',
      judul: 'Judul Laporan',
      urgent: true,
      kategori: 'Kategori',
      status: LaporanStatus.diproses,
      imageUrl:
      'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200',
    ),
  ].obs;

  void setTab(int index) {
    if (index < 0 || index > 1) return;
    activeTab.value = index;
  }

  void setBottomNav(int index) {
    bottomNavIndex.value = index;
    // TODO: Get.toNamed(...) jika route lain sudah ada
  }
}
