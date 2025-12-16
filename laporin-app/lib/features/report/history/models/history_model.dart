/// MODEL - HISTORY
/// ---------------------------------------------------
/// Dev Team: Adriyan
/// ---------------------------------------------------

class HistoryModel {
  final String id;
  final String judul;
  final String status; // Pending, Proses, Selesai
  final String tanggal;

  HistoryModel({
    required this.id,
    required this.judul,
    required this.status,
    required this.tanggal,
  });
}
