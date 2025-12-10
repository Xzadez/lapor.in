import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/reset_password_screen/model/reset_password_model.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import '../../../routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  // Form Key untuk validasi
  late GlobalKey<FormState> formKey;

  // Controllers untuk input text
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  // Models untuk reset password
  Rx<ResetPasswordModel> resetPasswordModelObj = ResetPasswordModel().obs;

  // Variable Loading
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    // Jangan dispose manual untuk menghindari error saat navigasi
    super.onClose();
  }

  // --- VALIDASI PASSWORD ---
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  // --- VALIDASI KONFIRMASI PASSWORD ---
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password wajib diisi';
    }
    if (value != passwordController.text) {
      return 'Password tidak sama';
    }
    return null;
  }

  // --- AKSI SIMPAN PASSWORD ---
  void onSavePassword() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    final screenHeight = MediaQuery.of(Get.context!).size.height;

    try {
      // Simulasi API Call
      await Future.delayed(const Duration(seconds: 2));

      resetPasswordModelObj.update((val) {
        val?.newPassword.value = passwordController.text;
        val?.confirmPassword.value = confirmPasswordController.text;
      });

      // --- SUKSES ---
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Password berhasil diubah, silahkan login',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: appTheme.greenCustom,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(
            bottom: screenHeight - 120,
            left: 20,
            right: 20,
          ),
          duration: const Duration(seconds: 3),
        ),
      );

      // Delay sedikit
      await Future.delayed(const Duration(seconds: 2));

      // --- NAVIGASI AKHIR ---
      Get.offAllNamed(AppRoutes.loginScreen);
    } catch (e) {
      // --- ERROR ---
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Gagal mengubah password'),
          backgroundColor: appTheme.redCustom,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: screenHeight - 120,
            left: 20,
            right: 20,
          ),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
