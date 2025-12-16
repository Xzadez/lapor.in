import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/detail_laporan_controller.dart';

class DetailLaporanScreen extends StatelessWidget {
  const DetailLaporanScreen({super.key});

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case "DITERIMA":
        return Colors.green;
      case "DIPROSES":
        return Colors.blue;
      case "DITOLAK":
      default:
        // Warna merah agak soft/pastel sesuai gambar
        return const Color(0xFFFF5252);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailLaporanController>();

    return Scaffold(
      backgroundColor: Colors.white,
      // 1. APP BAR PUTIH
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Hilangkan bayangan agar terlihat flat
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Colors.black,
              ),
              onPressed: () => Get.back(),
              padding: EdgeInsets.zero, // Agar icon pas di tengah lingkaran
            ),
          ),
        ),
        title: const Text(
          "Detail Laporan",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Obx(() {
        final laporan = controller.laporan;
        final status = controller.status.value;
        final alasan = controller.alasan.value;
        final themeColor = _getStatusColor(status);

        return SingleChildScrollView(
          child: Stack(
            children: [
              // ------------------------------------------------
              // LAYER 1: Header Image & Text (Background Merah)
              // ------------------------------------------------
              Container(
                height: 350, // Tinggi area merah
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(laporan["gambar"] ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  // Overlay Warna
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.85),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        status.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "Alasan ${status == 'DITOLAK' ? 'Ditolak' : 'Status'} adalah ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: alasan,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ------------------------------------------------
              // LAYER 2: Konten Putih (Overlap ke atas)
              // ------------------------------------------------
              Container(
                // Margin atas untuk mendorong container putih ke bawah
                // tapi membiarkannya menumpuk sedikit di atas area merah
                margin: const EdgeInsets.only(top: 300),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tags
                    Row(
                      children: [
                        _buildTag(laporan["urgensi"]!, const Color(0xFFFF5252)),
                        const SizedBox(width: 12),
                        _buildTag(
                          laporan["kategori"]!,
                          const Color(0xFF4DB6AC),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Judul Laporan
                    Text(
                      laporan["judul"]!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Pengirim & Waktu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          laporan["pengirim"]!,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          laporan["waktu"]!,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Deskripsi
                    Text(
                      laporan["deskripsi"]!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 50), // Spasi bawah tambahan
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Widget Tag
  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
