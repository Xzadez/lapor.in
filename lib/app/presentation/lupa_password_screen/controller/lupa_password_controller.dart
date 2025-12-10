import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import '../../../routes/app_routes.dart';

class LupaPasswordController extends GetxController {
  late TextEditingController emailController;
  late GlobalKey<FormState> formKey;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void onClose() {
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

      final screenHeight = MediaQuery.of(Get.context!).size.height;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Sukses: Kode OTP dikirim ke ${emailController.text}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
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

      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }
}
