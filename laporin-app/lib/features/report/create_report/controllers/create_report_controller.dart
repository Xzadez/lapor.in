import 'package:flutter/material.dart';

/// CONTROLLER - CREATE REPORT
/// ---------------------------------------------------
/// Scrum Master : Rafly
/// Dev Team     : Adriyan
/// ---------------------------------------------------

class CreateReportController {
  Future<void> kirimLaporan(BuildContext context, String judul, String isi) async {
    if (judul.isEmpty || isi.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lengkapi data laporan!")));
      return;
    }

    // Simulasi POST API
    await Future.delayed(const Duration(seconds: 2));
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Laporan Terkirim!")));
      Navigator.pop(context); // Kembali ke Home
    }
  }
}
