import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import '../../../core/app_export.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  // Form key for validation
  late GlobalKey<FormState> formKey;

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
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginModel.value = LoginModel();
  }

  @override
  void onClose() {
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
    FocusManager.instance.primaryFocus?.unfocus();
    final screenHeight = MediaQuery.of(Get.context!).size.height;

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (emailController.text.trim().isEmpty) {
      showEmailError.value = true;
      return;
    }

    isLoading.value = true;

    try {
      await Future.delayed(Duration(seconds: 2));

      loginModel.value?.email?.value = emailController.text.trim();
      loginModel.value?.password?.value = passwordController.text.trim();

      emailController.clear();
      passwordController.clear();
      showEmailError.value = false;

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Login Berhasil: Selamat datang di Lapor.in',
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

      await Future.delayed(Duration(milliseconds: 500));
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (error) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Login Gagal: Email atau password salah',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: appTheme.redCustom,
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
    } finally {
      isLoading.value = false;
    }
  }

  void onTapForgotPassword() {
    Get.toNamed(AppRoutes.lupaPasswordScreen);
  }

  void onTapRegisterNow() {
    Get.toNamed(AppRoutes.registerScreen);
  }
}
