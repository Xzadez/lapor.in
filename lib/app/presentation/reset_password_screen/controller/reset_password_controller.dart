import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/reset_password_screen/model/reset_password_model.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  final supabase = Supabase.instance.client;
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
      final UserResponse res = await supabase.auth.updateUser(
        UserAttributes(
          password: passwordController.text, // Password baru dikirim ke sini
        ),
      );
      if (res.user != null) {
        resetPasswordModelObj.update((val) {
          val?.newPassword.value = passwordController.text;
          val?.confirmPassword.value = confirmPasswordController.text;
        });

        await supabase.auth.signOut();
      }

      // --- SUKSES ---
      CustomSnackBar.show(
        message: 'Sukses! Silahkan login dengan password baru.',
        isError: false,
      );
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(AppRoutes.loginScreen);
    } on AuthException catch (e) {
      CustomSnackBar.show(message: 'Gagal: ${e.message}', isError: true);
    } catch (e) {
      CustomSnackBar.show(message: 'Terjadi kesalahn sistem.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
