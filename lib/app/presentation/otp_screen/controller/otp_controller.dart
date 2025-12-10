import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/otp_screen/model/otp_model.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import '../../../routes/app_routes.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();

  Rx<OtpModel> otpModelObj = OtpModel().obs;

  final isLoading = false.obs;

  @override
  void onClose() {
    super.onClose();
  }

  void onVerifyOtp() async {
    String code = otpController.text;
    final screenHeight = MediaQuery.of(Get.context!).size.height;

    if (code.length < 4) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Masukkan 4 digit kode OTP',
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
      return;
    }

    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      await Future.delayed(Duration(seconds: 2));

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Verifikasi Berhasil',
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
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(AppRoutes.lupaPasswordScreen);
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Kode OTP Salah, silahkan coba lagi',
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
            bottom: screenHeight - 140,
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
