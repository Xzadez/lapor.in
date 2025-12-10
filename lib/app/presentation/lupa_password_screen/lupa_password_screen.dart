import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/core/utils/size.utils.dart'; // Pastikan import .h berfungsi
import 'package:laporin/app/theme/text_style_helper.dart';
import 'package:laporin/app/theme/theme_helper.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/lupa_password_controller.dart';

class LupaPasswordScreen extends GetWidget<LupaPasswordController> {
  const LupaPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.85, -0.53),
            end: Alignment(0.85, 0.53),
            colors: [Color(0xFFABBBD3), Color(0xFF5981B5)],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 76.h,
            left: 32.h,
            right: 32.h,
            bottom: 50.h,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                // --- LOGO ---
                CustomImageView(
                  imagePath: 'assets/images/logo.png',
                  height: 80.h,
                  width: 80.h,
                ),

                // --- TITLE ---
                Container(
                  margin: EdgeInsets.only(top: 24.h),
                  child: Text(
                    'Selamat Datang Di Lapor.in',
                    style: TextStyleHelper.instance.title20ExtraBoldInter
                        .copyWith(color: Colors.white, height: 1.25),
                    textAlign: TextAlign.center,
                  ),
                ),

                // --- SUBTITLE ---
                Container(
                  margin: EdgeInsets.only(top: 8.h),
                  child: Text(
                    'Silahkan masukkan email untuk reset password',
                    style: TextStyleHelper.instance.label11RegularInter
                        .copyWith(color: appTheme.white_A700, height: 1.27),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 40.h),

                // --- FORM INPUT EMAIL ---
                CustomTextFormField(
                  controller: controller.emailController,
                  placeholder: 'Email Address',
                  inputType: TextInputType.emailAddress,
                  borderColor: appTheme.white_A700,
                  backgroundColor: const Color(0x47D9D9D9),
                  textColor: appTheme.white_A700,
                  validator: (value) => controller.validateEmail(value),
                ),

                SizedBox(height: 24.h),

                // --- BUTTON KIRIM OTP ---
                CustomButton(
                  text: 'Kirim kode OTP',
                  width: double.infinity,
                  backgroundColor: const Color(0xFFD9D9D9),
                  textColor: Colors.black,
                  onPressed: () => controller.onSendOtp(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
