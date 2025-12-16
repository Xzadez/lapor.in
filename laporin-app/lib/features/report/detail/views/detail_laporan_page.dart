import 'package:flutter/material.dart';

/// VIEW - DETAIL LAPORAN
/// ---------------------------------------------------
/// Product Owner : Rachmat Mauluddin
/// Scrum Master  : Maulana Ziddan, Satria
/// Dev Team      : Adriyan
/// ---------------------------------------------------

class DetailLaporanPage extends StatelessWidget {
  final String idLaporan; // Parameter ID

  const DetailLaporanPage({super.key, required this.idLaporan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Laporan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Laporan #$idLaporan", style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 10),
            const Text("Jalan Berlubang di Mawar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("Status: Sedang Diproses", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("Deskripsi lengkap laporan akan muncul di sini..."),
          ],
        ),
      ),
    );
  }
}
