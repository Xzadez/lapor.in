import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JoinMemberController extends GetxController {
  final codeController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final supabase = Supabase.instance.client;

  void submitCode() async {
    final code = codeController.text.trim();

    // 1. Validasi Input
    if (code.isEmpty) {
      errorMessage.value = "Kode undangan tidak boleh kosong";
      return;
    }

    // Reset Error
    errorMessage.value = "";
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      // --- SIMULASI LOGIC DATABASE ---
      // Nanti diganti dengan: await supabase.from('instances').select().eq('code', code)...
      await Future.delayed(const Duration(seconds: 2)); // Simulasi loading

      if (code.toUpperCase() == "ERROR") {
        throw "Kode tidak ditemukan";
      }

      // Jika Sukses:
      // 1. Update Profile User -> set role = 'warga'
      // 2. Link User ke Instance ID tersebut

      Get.snackbar("Berhasil", "Selamat bergabung! Anda sekarang warga RT 05.");
      Get.offAllNamed(AppRoutes.mainScreen); // Masuk ke Home
    } catch (e) {
      errorMessage.value = "Kode tidak valid atau kadaluarsa.";
      Get.snackbar("Gagal", "Terjadi kesalahan saat memverifikasi kode.");
    } finally {
      isLoading.value = false;
    }
  }

  void onTapScanQR() {
    // Nanti diarahkan ke layar Scanner Camera
    Get.toNamed(AppRoutes.qrScanScreen);
  }

  void onTapInputCode() {
    // Arahkan ke halaman Form Input yang tadi kita bahas
    // Kita namakan rute-nya: AppRoutes.inputCodeScreen
    Get.toNamed(AppRoutes.inputCodeScreen);
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
