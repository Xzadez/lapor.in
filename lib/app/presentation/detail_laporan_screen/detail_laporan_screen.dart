import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/detail_laporan_controller.dart';

class DetailLaporanScreen extends StatelessWidget {
  const DetailLaporanScreen({super.key});

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case "DITERIMA":
        return Colors.green;
      case "DIPROSES":
        return Colors.blue;
      case "DITOLAK":
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailLaporanController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          "Detail Laporan",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        final laporan = controller.laporan;
        final status = controller.status.value;
        final alasan = controller.alasan.value;
        final color = _statusColor(status);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                        children: [
                          TextSpan(
                            text: "Alasan ${status == 'DITOLAK' ? 'Ditolak' : 'Diterima'} adalah ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: alasan),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    laporan["gambar"] ?? "",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) =>
                        Container(height: 180, color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          child: const Text("Gambar tidak tersedia"),
                        ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        _buildTag(laporan["urgensi"]!, Colors.red),
                        const SizedBox(width: 8),
                        _buildTag(laporan["kategori"]!, Colors.teal),
                      ]),
                      const SizedBox(height: 12),
                      Text(
                        laporan["judul"]!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(laporan["pengirim"]!, style: const TextStyle(color: Colors.grey)),
                          Text(laporan["waktu"]!, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        laporan["deskripsi"]!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }
}
