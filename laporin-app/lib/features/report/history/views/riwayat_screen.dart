import 'package:flutter/material.dart';
import '../controllers/history_controller.dart';
import '../models/history_model.dart';

/// VIEW - RIWAYAT SCREEN
/// ---------------------------------------------------
/// Dev Team: Adriyan
/// ---------------------------------------------------

class RiwayatScreen extends StatelessWidget {
  RiwayatScreen({super.key});

  final HistoryController _controller = HistoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Laporan")),
      body: FutureBuilder<List<HistoryModel>>(
        future: _controller.loadHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada riwayat laporan."));
          }

          final data = snapshot.data!;
          
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(
                    item.status == "Selesai" ? Icons.check_circle : Icons.timer,
                    color: item.status == "Selesai" ? Colors.green : Colors.orange,
                  ),
                  title: Text(item.judul),
                  subtitle: Text("${item.tanggal} • ${item.status}"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigasi ke detail (jika diperlukan)
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
