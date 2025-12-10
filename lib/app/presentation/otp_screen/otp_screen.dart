import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/core/utils/size.utils.dart';
import 'package:laporin/app/theme/text_style_helper.dart';
import 'package:laporin/app/theme/theme_helper.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_pin_code_text_field.dart';
import 'controller/otp_controller.dart';

class OtpScreen extends GetWidget<OtpController> {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, 0.17),
            end: Alignment(1.00, 0.83),
            colors: [const Color(0xFFABBBD2), const Color(0xE55880B5)],
          ),
        ),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 40.h),
            child: Column(
              children: [
                SizedBox(height: 100.h),
                // --- JUDUL ---
                Text(
                  'Lupa password?\nTenang aja akun anda aman kok',
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.instance.title20ExtraBoldInter
                      .copyWith(
                        color: Colors.white,
                        height: 1.25,
                        fontSize: 20.fSize,
                      ),
                ),

                SizedBox(height: 100.h),
                // --- SUB JUDUL ---
                Text(
                  'Silahkan masukkan kode',
                  style: TextStyleHelper.instance.label11RegularInter.copyWith(
                    color: Colors.white,
                    fontSize: 11.fSize,
                  ),
                ),

                SizedBox(height: 16.h),

                // --- INPUT OTP (WIDGET BARU) ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: CustomPinCodeTextField(
                    context: context,
                    controller: controller.otpController,
                    onChanged: (value) {
                      controller.otpModelObj.update((val) {
                        val?.otpCode.value = value;
                      });
                    },
                  ),
                ),

                SizedBox(height: 40.h),

                // --- TOMBOL VERIFIKASI ---
                CustomButton(
                  text: 'Verifikasi',
                  width: double.infinity,
                  backgroundColor: const Color(0xFFD9D9D9),
                  textColor: Colors.black,
                  onPressed: () {
                    controller.onVerifyOtp();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
