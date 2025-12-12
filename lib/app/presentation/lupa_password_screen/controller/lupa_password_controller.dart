import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../routes/app_routes.dart';

class LupaPasswordController extends GetxController {
  final supabase = Supabase.instance.client;
  late TextEditingController emailController;
  late GlobalKey<FormState> formKey;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email tidak boleh kosong";
    }
    if (!GetUtils.isEmail(value)) {
      return "Format email tidak valid";
    }
    return null;
  }

  void onSendOtp() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading.value = true;

      try {
        await supabase.auth.resetPasswordForEmail(emailController.text.trim());
        CustomSnackBar.show(
          message: "Kode OTP dikirim ke ${emailController.text}",
          isError: false,
        );

        Get.toNamed(
          AppRoutes.otpScreen,
          arguments: emailController.text.trim(),
        );
      } on AuthException catch (e) {
        CustomSnackBar.show(
          message:
              'Gagal: Email tidak ditemukan atau terjadi keselahan: ${e.message}',
          isError: true,
        );
      } catch (e) {
        CustomSnackBar.show(
          message: 'Error: Terjadi keselahan sistem',
          isError: true,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
