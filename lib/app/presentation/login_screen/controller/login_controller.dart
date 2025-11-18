import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../models/login_model.dart';

class LoginController extends GetxController {
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Text controllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

  // Observable variables
  final isLoading = false.obs;
  final showEmailError = false.obs;

  // Model
  final loginModel = Rx<LoginModel?>(null);

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginModel.value = LoginModel();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      showEmailError.value = true;
      return null;
    }
    if (!GetUtils.isEmail(value)) {
      showEmailError.value = true;
      return null;
    }
    showEmailError.value = false;
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  // Handle login button tap
  void onTapLogin() async {
    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Show email error if email is empty
    if (emailController.text.trim().isEmpty) {
      showEmailError.value = true;
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Update model
      loginModel.value?.email?.value = emailController.text.trim();
      loginModel.value?.password?.value = passwordController.text.trim();

      // Clear form
      emailController.clear();
      passwordController.clear();
      showEmailError.value = false;

      // Show success message
      Get.snackbar(
        'Login Berhasil',
        'Selamat datang di Lapor.in',
        backgroundColor: appTheme.greenCustom,
        colorText: appTheme.whiteCustom,
        snackPosition: SnackPosition.TOP,
      );

      // Navigate to home screen (when available)
      // Get.offAllNamed(AppRoutes.homeScreen);
    } catch (error) {
      Get.snackbar(
        'Login Gagal',
        'Email atau password salah',
        backgroundColor: appTheme.redCustom,
        colorText: appTheme.whiteCustom,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Handle forgot password tap
  void onTapForgotPassword() {
    Get.snackbar(
      'Info',
      'Fitur lupa password akan segera tersedia',
      backgroundColor: appTheme.blueCustom,
      colorText: appTheme.whiteCustom,
      snackPosition: SnackPosition.TOP,
    );
  }

  // Handle register now tap
  void onTapRegisterNow() {
    Get.snackbar(
      'Info',
      'Fitur daftar akun akan segera tersedia',
      backgroundColor: appTheme.blueCustom,
      colorText: appTheme.whiteCustom,
      snackPosition: SnackPosition.TOP,
    );
  }
}
