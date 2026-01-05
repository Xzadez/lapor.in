class LaporanModel {
  String? id;
  String userId;
  String namaPelapor;
  String deskripsi;
  DateTime tanggalKejadian;
  String kategori;
  String? fotoUrl;
  String status;
  String? priority; // 1. Ubah jadi Nullable

  LaporanModel({
    this.id,
    required this.userId,
    required this.namaPelapor,
    required this.deskripsi,
    required this.tanggalKejadian,
    required this.kategori,
    this.fotoUrl,
    this.status = 'menunggu',
    this.priority, // 2. Hapus default = 'sedang'
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'nama_pelapor': namaPelapor,
      'deskripsi': deskripsi,
      'tanggal_kejadian': tanggalKejadian.toIso8601String(),
      'kategori': kategori,
      'foto_url': fotoUrl,
      'status': status,
      'priority': priority, // 3. Ini akan mengirim null jika tidak diisi
    };
  }
}
