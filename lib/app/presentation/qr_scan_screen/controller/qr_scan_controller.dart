import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
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

  Future<void> pickQrFromGallery() async {
    final ImagePicker picker = ImagePicker();

    try {
      // 1. Buka Galeri
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // 2. Analisa Gambar
        // Fungsi analyzeImage akan memicu onDetect jika QR ditemukan
        final BarcodeCapture? capture = await cameraController.analyzeImage(
          image.path,
        );

        if (capture != null && capture.barcodes.isNotEmpty) {
          final String code = capture.barcodes.first.rawValue ?? '';

          if (code.isNotEmpty) {
            // Jika ketemu, langsung proses kodenya
            await _processCode(code);
          } else {
            CustomSnackBar.show(
              message: "Gagal: QR Code tidak terbaca",
              isError: true,
            );
          }
        } else {
          CustomSnackBar.show(
            message: "Gagal: Tidak ditemukan QR Code pada gambar tersebut",
            isError: true,
          );
        }
      }
    } catch (e) {
      print("Error Pick Image: $e");
      CustomSnackBar.show(
        message: "Error ,Gagal mengambil gambar dari galeri",
        isError: true,
      );
    }
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
    // Cegah proses double
    if (isLoading.value) return;

    isLoading.value = true;

    // Tampilkan Loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) throw "Sesi habis, silakan login ulang.";

      // 1. CEK KODE DI DATABASE (Tabel community_invitations)
      final invitation =
          await supabase
              .from('community_invitations')
              .select()
              .eq('code', code)
              .maybeSingle(); // maybeSingle mengembalikan null jika tidak ada, bukan error

      // 2. VALIDASI: Apakah kode ditemukan?
      if (invitation == null) {
        throw "Kode undangan tidak ditemukan.";
      }

      // 3. VALIDASI: Apakah kode sudah terpakai?
      if (invitation['status'] == 'used') {
        throw "Kode undangan ini sudah pernah dipakai.";
      }

      // 4. VALIDASI: Apakah kode sudah kadaluarsa?
      final DateTime expiresAt = DateTime.parse(invitation['expires_at']);
      if (DateTime.now().isAfter(expiresAt)) {
        throw "Kode undangan sudah kadaluarsa.";
      }

      // --- JIKA SEMUA VALID, PROSES GABUNG ---

      final String communityId = invitation['community_id'];
      final String newRole = invitation['role'];

      // A. Update Profile User (Masukkan ke komunitas)
      await supabase
          .from('profiles')
          .update({
            'community_id': communityId,
            'role':
                newRole, // Set role sesuai undangan (misal: ketua_rt atau warga)
          })
          .eq('id', currentUser.id);

      // B. Tandai Undangan sebagai 'used' (Agar tidak bisa dipakai lagi)
      await supabase
          .from('community_invitations')
          .update({'status': 'used'})
          .eq('id', invitation['id']);

      Get.back(); // Tutup Loading

      // C. Sukses & Pindah ke Home
      CustomSnackBar.show(
        message: "Berhasil Bergabung! Selamat datang di komunitas baru Anda.",
        isError: false,
      );

      Get.offAllNamed(AppRoutes.mainScreen);
    } catch (e) {
      Get.back(); // Tutup loading jika error

      Get.defaultDialog(
        title: "Gagal",
        middleText: e.toString().replaceAll("Exception: ", ""),
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
