import 'package:intl/intl.dart';

class LaporanModel {
  final String id;
  final String tanggal;
  final String judul; // Versi pendek (untuk List)
  final String deskripsi; // Versi lengkap (untuk Detail) <-- TAMBAH INI
  final String kategori;
  final bool urgent;
  final String imageUrl;
  final int statusIndex;
  final bool rejected;
  final bool cancelled;
  final String? estimasi;

  LaporanModel({
    required this.id,
    required this.tanggal,
    required this.judul,
    required this.deskripsi, // <-- TAMBAH INI
    required this.kategori,
    required this.urgent,
    required this.imageUrl,
    required this.statusIndex,
    this.rejected = false,
    this.cancelled = false,
    this.estimasi,
  });

  factory LaporanModel.fromJson(Map<String, dynamic> json) {
    String statusDb = json['status'] ?? 'menunggu';

    // Logika Status Index (Sama seperti sebelumnya)
    int idx = 1;
    bool isRejected = false;
    bool isCancelled = false;

    if (statusDb == 'dibatalkan') {
      idx = 0;
      isCancelled = true;
    } else if (statusDb == 'menunggu')
      idx = 1;
    else if (statusDb == 'diterima')
      idx = 2;
    else if (statusDb == 'diproses')
      idx = 3;
    else if (statusDb == 'selesai')
      idx = 4;
    else if (statusDb == 'ditolak') {
      idx = 1;
      isRejected = true;
    }

    // Format Tanggal
    String formattedDate = "";
    if (json['tanggal_kejadian'] != null) {
      try {
        DateTime dt = DateTime.parse(json['tanggal_kejadian']);
        formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(dt);
      } catch (e) {
        formattedDate = json['tanggal_kejadian'];
      }
    }

    // LOGIKA DESKRIPSI
    String deskripsiFull = json['deskripsi'] ?? '-';

    // Buat Judul Singkat (hanya untuk tampilan List Card)
    String judulSingkat =
        deskripsiFull.length > 30
            ? "${deskripsiFull.substring(0, 30)}..."
            : deskripsiFull;

    return LaporanModel(
      id: json['id'],
      tanggal: formattedDate,
      judul: judulSingkat, // Masukkan yang pendek
      deskripsi: deskripsiFull, // Masukkan yang FULL
      kategori: json['kategori'] ?? 'Umum',
      urgent: (json['priority'] == 'tinggi' || json['priority'] == 'high'),
      imageUrl: json['foto_url'] ?? 'https://via.placeholder.com/300',
      statusIndex: idx,
      rejected: isRejected,
      cancelled: isCancelled,
      estimasi: json['estimasi'],
    );
  }
}
