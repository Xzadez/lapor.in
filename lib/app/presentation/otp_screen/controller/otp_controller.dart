import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:laporin/app/presentation/otp_screen/model/otp_model.dart';
import 'package:laporin/app/theme/theme_helper.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../routes/app_routes.dart';

class OtpController extends GetxController {
  final supabase = Supabase.instance.client;
  TextEditingController otpController = TextEditingController();
  Rx<OtpModel> otpModelObj = OtpModel().obs;
  final isLoading = false.obs;

  String email = "";

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments ?? '';
    if (email.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar("Error", "Sesi habis, silakan input email ulang.");
        Get.offAllNamed(AppRoutes.loginScreen); // Atau ke Lupa Password
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onVerifyOtp() async {
    String code = otpController.text;

    if (code.length < 6) {
      CustomSnackBar.show(message: 'Masukkan 6 digit kode OTP', isError: true);
      return;
    }

    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final AuthResponse res = await supabase.auth.verifyOTP(
        type: OtpType.recovery,
        token: code,
        email: email,
      );

      if (res.session != null) {
        CustomSnackBar.show(message: 'Verifikasi Berhasil', isError: false);

        Get.offNamed(AppRoutes.resetPasswordScreen);
      }
    } on AuthException catch (e) {
      CustomSnackBar.show(
        message: 'Gagal Verifikasi, Kode OTP Salah atau Kadaluarsa.',
        isError: true,
      );
      print("Error asli $e");
    } catch (e) {
      CustomSnackBar.show(
        message: 'ErrorL: Terjadi kesalahan sistem.',
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
