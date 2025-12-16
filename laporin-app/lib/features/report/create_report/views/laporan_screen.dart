import 'package:flutter/material.dart';
import '../controllers/create_report_controller.dart';

/// VIEW - LAPORAN SCREEN (INPUT)
/// ---------------------------------------------------
/// Scrum Master : Rafly
/// Dev Team     : Adriyan
/// ---------------------------------------------------

class LaporanScreen extends StatelessWidget {
  LaporanScreen({super.key});

  final CreateReportController _controller = CreateReportController();
  final TextEditingController _judulCtrl = TextEditingController();
  final TextEditingController _isiCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buat Laporan Baru")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _judulCtrl,
              decoration: const InputDecoration(labelText: "Judul Laporan", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _isiCtrl,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Deskripsi Kejadian", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _controller.kirimLaporan(context, _judulCtrl.text, _isiCtrl.text);
                },
                child: const Text("KIRIM LAPORAN"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
