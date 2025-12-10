import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/core/utils/image_constant.dart'; // Pastikan path benar
import 'package:laporin/app/core/utils/size.utils.dart';
import 'package:laporin/app/theme/text_style_helper.dart';
import 'package:laporin/app/theme/theme_helper.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/reset_password_controller.dart';

class ResetPasswordScreen extends GetWidget<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

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
                // --- TITLE ---
                SizedBox(height: 40.h),
                Text(
                  'Buat Password Baru',
                  style: TextStyleHelper.instance.title20ExtraBoldInter
                      .copyWith(
                        color: Colors.white,
                        height: 1.25,
                        fontSize: 24.fSize,
                      ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 12.h),

                // --- SUBTITLE ---
                Text(
                  'Password baru anda harus berbeda dari password yang digunakan sebelumnya',
                  style: TextStyleHelper.instance.label11RegularInter.copyWith(
                    color: appTheme.white_A700.withOpacity(0.8),
                    height: 1.5,
                    fontSize: 12.fSize,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 60.h),

                // --- INPUT PASSWORD BARU ---
                CustomTextFormField(
                  controller: controller.passwordController,
                  placeholder: 'Password Baru',
                  inputType: TextInputType.visiblePassword,
                  isPasswordField: true, // Fitur hide/show password
                  suffixIconPath:
                      ImageConstant.imgGroup15, // Icon mata (sesuaikan path)
                  borderColor: appTheme.white_A700,
                  backgroundColor: const Color(0x47D9D9D9),
                  textColor: appTheme.white_A700,
                  validator: (value) => controller.validatePassword(value),
                ),

                SizedBox(height: 16.h),

                // --- INPUT KONFIRMASI PASSWORD ---
                CustomTextFormField(
                  controller: controller.confirmPasswordController,
                  placeholder: 'Ulangi Password Baru',
                  inputType: TextInputType.visiblePassword,
                  isPasswordField: true,
                  suffixIconPath: ImageConstant.imgGroup15,
                  borderColor: appTheme.white_A700,
                  backgroundColor: const Color(0x47D9D9D9),
                  textColor: appTheme.white_A700,
                  validator:
                      (value) => controller.validateConfirmPassword(value),
                ),

                SizedBox(height: 40.h),

                // --- TOMBOL SIMPAN ---
                Obx(() {
                  return CustomButton(
                    text:
                        controller.isLoading.value
                            ? 'Menyimpan...'
                            : 'Simpan Password',
                    width: double.infinity,
                    backgroundColor: const Color(0xFFD9D9D9),
                    textColor: Colors.black,
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () => controller.onSavePassword(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
