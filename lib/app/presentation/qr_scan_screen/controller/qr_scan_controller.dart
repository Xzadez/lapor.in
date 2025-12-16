import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QrScanController extends GetxController {
  // Controller bawaan package MobileScanner
  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed:
        DetectionSpeed.noDuplicates, // Mencegah scan berulang-ulang cepat
    returnImage: false,
  );

  final isLoading = false.obs;
  final supabase = Supabase.instance.client;

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  // Fungsi yang dipanggil saat QR terdeteksi
  void onDetect(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;

    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        final String code = barcode.rawValue!;
        debugPrint('QR Code Found: $code');

        // 1. Matikan kamera sementara agar tidak scan terus menerus
        cameraController.stop();

        // 2. Proses Validasi Kode
        await _processCode(code);
        break; // Ambil satu saja
      }
    }
  }

  Future<void> _processCode(String code) async {
    isLoading.value = true;

    // Tampilkan Loading Dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // --- SIMULASI LOGIC DATABASE ---
      // Cek apakah 'code' ada di tabel 'instances' Supabase
      await Future.delayed(const Duration(seconds: 2)); // Dummy delay

      // Validasi Dummy (Ganti dengan logic asli nanti)
      if (code.startsWith("LPR-")) {
        // SUKSES
        Get.back(); // Tutup loading
        Get.snackbar("Berhasil", "Bergabung ke Instansi: $code");
        Get.offAllNamed(AppRoutes.mainScreen); // Masuk Home
      } else {
        throw "QR Code tidak valid atau bukan milik aplikasi Laporin.";
      }
    } catch (e) {
      Get.back(); // Tutup loading

      // Tampilkan Error Dialog & Tombol Scan Ulang
      Get.defaultDialog(
        title: "Gagal",
        middleText: e.toString(),
        textConfirm: "Scan Ulang",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Tutup dialog
          cameraController.start(); // Nyalakan kamera lagi
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle Flash/Senter
  void toggleTorch() => cameraController.toggleTorch();

  // Ganti Kamera Depan/Belakang
  void switchCamera() => cameraController.switchCamera();
}
