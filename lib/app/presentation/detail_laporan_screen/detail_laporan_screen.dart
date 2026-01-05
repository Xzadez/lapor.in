import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/detail_laporan_controller.dart';

class DetailLaporanScreen extends GetView<DetailLaporanController> {
  const DetailLaporanScreen({super.key});

  // Helper Warna Status
  Color _getStatusColor(String status) {
    switch (status) {
      case "SELESAI":
        return Colors.green;
      case "DIPROSES":
      case "DITERIMA":
        return Colors.blue;
      case "MENUNGGU":
        return Colors.orange;
      case "DITOLAK":
        return const Color(0xFFFF5252); // Merah
      case "DIBATALKAN":
        return Colors.grey;
      default:
        return const Color(0xFF35BBA4); // Tosca Default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
              padding: EdgeInsets.zero,
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
        // Ambil data dari Controller
        final data = controller.laporanData;

        // Jika data belum load (misal null), tampilkan loading/kosong
        if (data.isEmpty)
          return const Center(child: CircularProgressIndicator());

        final statusText = controller.statusLabel.value;
        final statusDesc = controller.statusDesc.value;
        final themeColor = _getStatusColor(statusText);

        return SingleChildScrollView(
          child: Stack(
            children: [
              // ------------------------------------------------
              // LAYER 1: Header Image & Status (Background Warna Dinamis)
              // ------------------------------------------------
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      data["gambar"] ?? 'https://via.placeholder.com/400',
                    ),
                    fit: BoxFit.cover,
                    // Handle error image loading
                    onError: (exception, stackTrace) {},
                  ),
                ),
                child: Container(
                  // Overlay Warna Dinamis
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
                      // STATUS UTAMA (DITOLAK/DIPROSES/DLL)
                      Text(
                        statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // KETERANGAN / ALASAN / ESTIMASI
                      Text(
                        statusDesc,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ------------------------------------------------
              // LAYER 2: Konten Putih (Detail)
              // ------------------------------------------------
              Container(
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
                    // Tags (Urgent & Kategori)
                    Row(
                      children: [
                        if (data["urgensi"] == "Urgent")
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: _buildTag("URGENT", const Color(0xFFFF5252)),
                          ),
                        _buildTag(
                          data["kategori"] ?? "Umum",
                          const Color(0xFF4DB6AC),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Waktu & Pengirim
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              data["pengirim"] ?? "-",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              data["waktu"] ?? "-",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Deskripsi (Judul dijadikan Isi)
                    const Text(
                      "Deskripsi Laporan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data["deskripsi"] ?? "-",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
