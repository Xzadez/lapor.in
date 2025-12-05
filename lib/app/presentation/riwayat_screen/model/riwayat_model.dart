class RiwayatModel {
  final String tanggal;
  final String judul;
  final String kategori;
  final String urgensi;
  final String gambar;
  final String status; // proses, ditolak, selesai

  RiwayatModel({
    required this.tanggal,
    required this.judul,
    required this.urgensi,
    required this.kategori,
    required this.gambar,
    required this.status,
  });
}
