import 'package:get/get.dart';

class LaporanItem {
  final String tanggal;
  final String judul;
  final bool urgent;
  final String kategori;
  final String imageUrl;

  const LaporanItem({
    required this.tanggal,
    required this.judul,
    required this.urgent,
    required this.kategori,
    required this.imageUrl,
  });
}

class PengurusBerandaController extends GetxController {
  /// 0: Lingkungan, 1: Fasilitas, 2: Kegiatan
  final RxInt activeTabIndex = 0.obs;

  /// 0: Beranda, 1: Laporan, 2: Riwayat, 3: Akun
  final RxInt bottomNavIndex = 0.obs;

  final List<String> tabs = const ['Lingkungan', 'Fasilitas', 'Kegiatan'];

  final RxList<String> bannerImages = <String>[
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=1200',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=1200',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=1200',
  ].obs;

  final RxList<LaporanItem> laporan = <LaporanItem>[
    const LaporanItem(
      tanggal: '20 Oktober 2025',
      judul: 'Judul Laporan',
      urgent: true,
      kategori: 'Kategori',
      imageUrl:
      'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200',
    ),
    const LaporanItem(
      tanggal: '20 Oktober 2025',
      judul: 'Judul Laporan',
      urgent: true,
      kategori: 'Kategori',
      imageUrl:
      'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200',
    ),
    const LaporanItem(
      tanggal: '20 Oktober 2025',
      judul: 'Judul Laporan',
      urgent: true,
      kategori: 'Kategori',
      imageUrl:
      'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200',
    ),
  ].obs;

  void setActiveTab(int index) {
    if (index < 0 || index >= tabs.length) return;
    activeTabIndex.value = index;

    // TODO: filter data laporan per tab kalau kamu punya API / kategori asli.
  }

  void setBottomNav(int index) {
    if (index < 0 || index > 3) return;
    bottomNavIndex.value = index;

    // TODO: navigasi ke page lain kalau sudah ada route.
    // contoh: if (index == 1) Get.toNamed(Routes.laporan);
  }
}
