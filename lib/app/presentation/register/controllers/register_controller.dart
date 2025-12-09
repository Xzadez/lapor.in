import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/register/model/register_model.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import 'package:laporin/app/routes/app_routes.dart';

class RegisterController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController birthDayController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;

  // Observables
  final isLoading = false.obs;
  final registerModel = RegisterModel().obs;

  @override
  void onInit() {
    super.onInit();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    birthDayController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthDayController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.onClose();
  }

  // --- Functions ---

  // Fungsi untuk menampilkan DatePicker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        Duration(days: 365 * 17),
      ), // Default 17 tahun lalu
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: appTheme.indigo_400_e5),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      registerModel.value.birthDay.value = picked;
      birthDayController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  // --- Validations ---

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  String? validateRepeatPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ulangi password tidak boleh kosong';
    }
    if (value != passwordController.text) {
      return 'Password tidak sama';
    }
    return null;
  }

  // --- Actions ---

  void onTapRegister() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    try {
      // Simulate API Call
      await Future.delayed(Duration(seconds: 2));

      Get.snackbar(
        'Berhasil',
        'Akun berhasil dibuat. Silahkan login.',
        backgroundColor: appTheme.greenCustom,
        colorText: appTheme.whiteCustom,
        snackPosition: SnackPosition.TOP,
      );

      // Navigate ke Login atau Home
      Get.offNamed(AppRoutes.loginScreen);
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Terjadi kesalahan saat mendaftar.',
        backgroundColor: appTheme.redCustom,
        colorText: appTheme.whiteCustom,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onTapLogin() {
    Get.back();
  }
}
