import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/app_export.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  // Text controllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

  // Observable variables
  final isLoading = false.obs;
  final showEmailError = false.obs;

  // Model
  final loginModel = Rx<LoginModel?>(null);

  // Supabase client
  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
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
  void onTapLogin(GlobalKey<FormState> formKey) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (emailController.text.trim().isEmpty) {
      showEmailError.value = true;
      return;
    }

    isLoading.value = true;

    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (res.session != null) {
        await _checkUserRole(res.session!.user.id);
      }
    } on AuthException catch (e) {
      String message = e.message;
      if (message.toLowerCase().contains('email not confirmed')) {
        message =
            "Email belum diverifikasi. Silahkan cek inbox/spam email Anda.";
      } else if (message.toLowerCase().contains('invalid login credentials')) {
        message = 'Email atau password salah.';
      }
      CustomSnackBar.show(message: 'Login Gagal: $message', isError: true);
    } catch (error) {
      CustomSnackBar.show(message: 'Terjadi kesalahan sistem.', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _checkUserRole(String userId) async {
    try {
      final data =
          await supabase
              .from('profiles')
              .select('role')
              .eq('id', userId)
              .maybeSingle();

      // Bersihkan controller
      emailController.clear();
      passwordController.clear();
      showEmailError.value = false;

      CustomSnackBar.show(
        message: 'Login Berhasil: Selamat datang di Lapor.in',
        isError: false,
      );

      // --- PENENTUAN ARAH NAVIGASI ---
      if (data == null || data['role'] == null || data['role'] == '') {
        Get.offAllNamed(AppRoutes.selectedRoleScreen);
      } else {
        Get.offAllNamed(AppRoutes.mainScreen);
      }
    } catch (e) {
      print("Error Check Role: $e");
      Get.offAllNamed(AppRoutes.mainScreen);
    }
  }

  void onTapForgotPassword() {
    Get.toNamed(AppRoutes.lupaPasswordScreen);
  }

  void onTapRegisterNow() {
    Get.toNamed(AppRoutes.registerScreen);
  }
}
