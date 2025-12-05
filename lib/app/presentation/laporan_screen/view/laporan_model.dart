class LaporanModel {
  final String tanggal;
  final String judul;
  final String kategori;
  final bool urgent;
  final String imageUrl;
  final int statusIndex;
  final bool rejected;
  final String? estimasi;

  LaporanModel({
    required this.tanggal,
    required this.judul,
    required this.kategori,
    required this.urgent,
    required this.imageUrl,
    required this.statusIndex,
    this.rejected = false,
    this.estimasi,
  });
}
