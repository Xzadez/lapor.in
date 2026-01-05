import 'package:intl/intl.dart';

class LaporanModel {
  final String id;
  final String tanggal;
  final String judul;
  final String kategori;
  final bool urgent;
  final String imageUrl;
  final int statusIndex; // Hasil konversi dari text 'status'
  final bool rejected; // Hasil pengecekan 'status' == 'ditolak'
  final bool cancelled;
  final String? estimasi;

  LaporanModel({
    required this.id,
    required this.tanggal,
    required this.judul,
    required this.kategori,
    required this.urgent,
    required this.imageUrl,
    required this.statusIndex,
    this.rejected = false,
    this.cancelled = false,
    this.estimasi,
  });

  // --- FACTORY: MAPPING DATABASE -> UI ---
  factory LaporanModel.fromJson(Map<String, dynamic> json) {
    // 1. LOGIKA STATUS INDEX & REJECTED
    // Kita baca text dari database, lalu tentukan angkanya
    String statusDb = json['status'] ?? 'menunggu';
    int idx = 1;
    bool isRejected = false;
    bool isCancelled = false;

    // Mapping Status Text ke Angka Progress Bar
    if (statusDb == 'dibatalkan') {
      idx = 0; // Paling awal
      isCancelled = true;
    }
    if (statusDb == 'diterima')
      idx = 1;
    else if (statusDb == 'diproses')
      idx = 2;
    else if (statusDb == 'selesai')
      idx = 3;
    else if (statusDb == 'ditolak') {
      idx = 0;
      isRejected = true; // Jika status ditolak, set flag ini true
    }

    // 2. FORMAT TANGGAL (Database ISO -> Format Indo)
    String formattedDate = "";
    if (json['tanggal_kejadian'] != null) {
      try {
        DateTime dt = DateTime.parse(json['tanggal_kejadian']);
        formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(dt);
      } catch (e) {
        formattedDate = json['tanggal_kejadian'];
      }
    }

    // 3. LOGIKA PRIORITY (URGENT)
    // Jika priority dari DB adalah 'tinggi' atau 'high', anggap urgent
    bool isUrgent =
        (json['priority'] == 'tinggi' || json['priority'] == 'high');

    // 4. JUDUL (Potong Deskripsi jika kepanjangan)
    String deskripsiFull = json['deskripsi'] ?? '-';
    String judulSingkat =
        deskripsiFull.length > 30
            ? "${deskripsiFull.substring(0, 30)}..."
            : deskripsiFull;

    return LaporanModel(
      id: json['id'],
      tanggal: formattedDate,
      judul: judulSingkat, // Kita pakai deskripsi sebagai judul card
      kategori: json['kategori'] ?? 'Umum',
      urgent: isUrgent,
      // Placeholder jika foto kosong/error URL
      imageUrl: json['foto_url'] ?? 'https://via.placeholder.com/300',
      statusIndex: idx,
      rejected: isRejected,
      cancelled: isCancelled,
      estimasi: json['estimasi'], // Kolom baru yang kita buat tadi
    );
  }
}
