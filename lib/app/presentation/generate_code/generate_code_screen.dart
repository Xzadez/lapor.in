import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'controller/generate_code_controller.dart';

class GenerateCodeScreen extends GetView<GenerateCodeController> {
  const GenerateCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color themeColor = const Color(0xFF35BBA4);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(), // Tombol Close (X)
        ),
        title: const Text(
          "Buat Undangan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- INFO CALON ANGGOTA ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  const Text(
                    "INVITE USER",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.candidateData.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: themeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      controller.candidateData.displayRole,
                      style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // --- AREA KODE GENERATOR ---
            Obx(() {
              // STATE 1: LOADING
              if (controller.isLoading.value) {
                return Column(
                  children: [
                    CircularProgressIndicator(color: themeColor),
                    const SizedBox(height: 16),
                    const Text("Sedang membuat kode unik..."),
                  ],
                );
              }

              // STATE 2: KODE SUDAH JADI
              if (controller.generatedCode.value.isNotEmpty) {
                return Column(
                  children: [
                    const Text(
                      "KODE UNDANGAN",
                      style: TextStyle(letterSpacing: 1, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Screenshot(
                      controller: controller.screenshotController,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white, // QR butuh background putih
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Widget QR Code dari package qr_flutter
                            QrImageView(
                              data:
                                  controller
                                      .generatedCode
                                      .value, // Data yang diubah jadi QR
                              version: QrVersions.auto,
                              size: 200.0,
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(height: 16),
                            // Teks Kode di bawah QR
                            Text(
                              controller.generatedCode.value,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 4,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ------------------------------------
                    const SizedBox(height: 24),

                    // TOMBOL AKSI (Salin & Share)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tombol Salin Teks
                        OutlinedButton.icon(
                          onPressed: controller.copyToClipboard,
                          icon: const Icon(Icons.copy, size: 18),
                          label: const Text("Salin Kode"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black87,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Tombol Share QR Image
                        Obx(
                          () => ElevatedButton.icon(
                            onPressed:
                                controller.isSharing.value
                                    ? null
                                    : controller.shareQrCode,
                            icon:
                                controller.isSharing.value
                                    ? Container(
                                      width: 18,
                                      height: 18,
                                      padding: const EdgeInsets.all(2),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Icon(
                                      Icons.share,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                            label: Text(
                              controller.isSharing.value
                                  ? "Memproses..."
                                  : "Bagikan QR",
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Text(
                      "Kode berlaku selama 24 Jam.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                );
              }

              // STATE 3: BELUM ADA KODE (AWAL) - SAMA SEPERTI SEBELUMNYA
              return Column(
                children: [
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Tekan tombol di bawah untuk\nmembuat QR Code undangan.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              );
            }),

            const Spacer(),

            // --- TOMBOL UTAMA BAWAH (SAMA SEPERTI SEBELUMNYA) ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Obx(() {
                if (controller.generatedCode.value.isNotEmpty) {
                  return ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "SELESAI",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return ElevatedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : controller.generateInvitation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "BUAT KODE UNDANGAN",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
