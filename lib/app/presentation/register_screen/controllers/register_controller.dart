import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:laporin/app/presentation/register_screen/model/register_model.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  //Instance Supabase Client
  final supabase = Supabase.instance.client;

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

  void onTapRegister(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (registerModel.value.birthDay.value == null) {
      CustomSnackBar.show(
        message: "Error: Silahkan pilih tanggal lahir.",
        isError: true,
      );
    }

    isLoading.value = true;
    try {
      // Simulate API Call
      final AuthResponse res = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
        data: {
          'first_name': firstNameController.text.trim(),
          'last_name': lastNameController.text.trim(),
          'username': usernameController.text.trim(),
          'birth_day': registerModel.value.birthDay.value!.toIso8601String(),
          'role': null,
        },
      );

      if (res.user != null) {
        CustomSnackBar.show(
          message: "Registrasi berhasil! Silahkan cek email untuk verifikasi.",
          isError: false,
        );
        Get.offNamed(AppRoutes.loginScreen);
      }
    } on AuthException catch (e) {
      CustomSnackBar.show(
        message: "Gagal Register : ${e.message}.",
        isError: true,
      );
    } catch (e) {
      String errorMessage = "Terjadi kesalahan saat mendaftar";
      if (e.toString().contains('username')) {
        errorMessage = 'Username sudah digunakan.';
      }
      CustomSnackBar.show(message: "Error : $errorMessage}.", isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void onTapLogin() {
    Get.back();
  }
}
