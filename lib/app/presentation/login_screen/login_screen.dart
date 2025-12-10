import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:laporin/app/core/utils/image_constant.dart';
import 'package:laporin/app/core/utils/size.utils.dart';
import 'package:laporin/app/theme/text_style_helper.dart';
import 'package:laporin/app/theme/theme_helper.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';
import './controller/login_controller.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});

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
        child: Stack(
          children: [
            // --- FORM INPUT ---
            Positioned.fill(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: 76.h,
                  left: 32.h,
                  right: 32.h,
                  bottom: 100.h,
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CustomImageView(
                        imagePath: 'assets/images/logo.png',
                        height: 44.h,
                        width: 44.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 18.h),
                        child: Text(
                          'Selamat Datang Di Lapor.in',
                          style: TextStyleHelper.instance.title20ExtraBoldInter
                              .copyWith(height: 1.25),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        child: Text(
                          'Silahkan login terlebih dahulu',
                          style: TextStyleHelper.instance.label11RegularInter
                              .copyWith(
                                color: appTheme.white_A700,
                                height: 1.27,
                              ),
                        ),
                      ),
                      CustomTextFormField(
                        controller: controller.emailController,
                        placeholder: 'Email Address',
                        inputType: TextInputType.emailAddress,
                        borderColor: appTheme.white_A700,
                        backgroundColor: appTheme.color47D9D9,
                        textColor: appTheme.white_A700,
                        margin: EdgeInsets.only(top: 52.h),
                        validator: (value) => controller.validateEmail(value),
                      ),
                      Obx(() {
                        return controller.showEmailError.value
                            ? Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 4.h),
                              child: Text(
                                '*Silahkan masukkan email terlebih dahulu',
                                style: TextStyleHelper
                                    .instance
                                    .label11RegularInter
                                    .copyWith(
                                      color: appTheme.colorB7FF00,
                                      height: 1.27,
                                    ),
                              ),
                            )
                            : SizedBox.shrink();
                      }),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        controller: controller.passwordController,
                        placeholder: 'Password',
                        inputType: TextInputType.visiblePassword,
                        isPasswordField: true,
                        suffixIconPath: ImageConstant.imgGroup15,
                        borderColor: appTheme.white_A700,
                        backgroundColor: appTheme.color47D9D9,
                        textColor: appTheme.white_A700,
                        margin: EdgeInsets.only(top: 4.h),
                        validator:
                            (value) => controller.validatePassword(value),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 10.h),
                        child: GestureDetector(
                          onTap: () => controller.onTapForgotPassword(),
                          child: Text(
                            'Lupa password?',
                            style: TextStyleHelper.instance.label11RegularInter
                                .copyWith(
                                  color: appTheme.white_A700,
                                  height: 1.27,
                                ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 76.h),
                        child: Obx(() {
                          return CustomButton(
                            text:
                                controller.isLoading.value
                                    ? 'Loading...'
                                    : 'Login',
                            width: double.infinity,
                            backgroundColor: appTheme.blue_gray_100,
                            textColor: appTheme.black_900,
                            onPressed:
                                controller.isLoading.value
                                    ? null
                                    : () => controller.onTapLogin(),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- FOOTER ---
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 32.h),
                child: GestureDetector(
                  onTap: () => controller.onTapRegisterNow(),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Tidak punya akun? ',
                          style: TextStyleHelper.instance.body14RegularInter
                              .copyWith(height: 1.21),
                        ),
                        TextSpan(
                          text: 'Daftar sekarang',
                          style: TextStyleHelper.instance.body14BoldInter
                              .copyWith(height: 1.21),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
