import 'package:flutter/material.dart';

/// CONTROLLER - HOME
/// ---------------------------------------------------
/// Scrum Master : Rachmat Mauluddin
/// Dev Team     : Adriyan, Maulana Ziddan
/// Deskripsi    : Mengambil data statistik dashboard
/// ---------------------------------------------------

class HomeController {
  // Simulasi data statistik laporan
  final ValueNotifier<int> totalLaporan = ValueNotifier(0);
  final ValueNotifier<int> laporanSelesai = ValueNotifier(0);

  Future<void> loadDashboardData() async {
    // Simulasi loading API
    await Future.delayed(const Duration(seconds: 1));
    
    // Update data (ceritanya dapat dari API)
    totalLaporan.value = 15;
    laporanSelesai.value = 12;
  }
}
