import 'package:flutter/material.dart';
import '../models/history_model.dart';

/// CONTROLLER - HISTORY
/// ---------------------------------------------------
/// Dev Team: Adriyan
/// Deskripsi: Mengambil list riwayat laporan user
/// ---------------------------------------------------

class HistoryController {
  Future<List<HistoryModel>> loadHistory() async {
    // Simulasi delay API
    await Future.delayed(const Duration(seconds: 1));

    // Simulasi data dummy
    return [
      HistoryModel(id: "LAP-001", judul: "Jalan Rusak", status: "Selesai", tanggal: "12 Des 2025"),
      HistoryModel(id: "LAP-002", judul: "Sampah Menumpuk", status: "Proses", tanggal: "14 Des 2025"),
      HistoryModel(id: "LAP-003", judul: "Lampu Jalan Mati", status: "Pending", tanggal: "16 Des 2025"),
    ];
  }
}
