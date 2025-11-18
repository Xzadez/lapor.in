import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';
import './controller/login_controller.dart';

class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.85, -0.53),
            end: Alignment(0.85, 0.53),
            colors: [
              Color(0xFFABBBD2),
              appTheme.colorB5E558,
            ],
          ),
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 76.h,
                    left: 32.h,
                    right: 32.h,
                  ),
                  child: Column(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgTowers,
                        height: 44.h,
                        width: 44.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 18.h),
                        child: Text(
                          'Selamat Datang Di Lapor.in',
                          style: TextStyleHelper.instance.title20ExtraBoldInter
                              .copyWith(height: 1.25),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        child: Text(
                          'Silahkan login terlebih dahulu',
                          style: TextStyleHelper.instance.label11RegularInter
                              .copyWith(
                                  color: appTheme.white_A700, height: 1.27),
                        ),
                      ),
                      CustomTextFormField(
                        controller: controller.emailController,
                        placeholder: 'Email Address',
                        inputType: TextInputType.emailAddress,
                        borderColor: appTheme.red_A700,
                        backgroundColor: appTheme.color47D9D9,
                        textColor: appTheme.white_A700,
                        margin: EdgeInsets.only(top: 52.h),
                        validator: (value) {
                          return controller.validateEmail(value);
                        },
                      ),
                      Obx(() {
                        return controller.showEmailError.value
                            ? Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 4.h),
                                child: Text(
                                  '*Silahkan masukkan email terlebih dahulu',
                                  style: TextStyleHelper
                                      .instance.label11RegularInter
                                      .copyWith(
                                          color: appTheme.colorB7FF00,
                                          height: 1.27),
                                ),
                              )
                            : SizedBox.shrink();
                      }),
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
                        validator: (value) {
                          return controller.validatePassword(value);
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 10.h),
                        child: GestureDetector(
                          onTap: () {
                            controller.onTapForgotPassword();
                          },
                          child: Text(
                            'Lupa password?',
                            style: TextStyleHelper.instance.label11RegularInter
                                .copyWith(
                                    color: appTheme.white_A700, height: 1.27),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 76.h),
                        child: Obx(() {
                          return CustomButton(
                            text: controller.isLoading.value
                                ? 'Loading...'
                                : 'Login',
                            width: double.infinity,
                            backgroundColor: appTheme.blue_gray_100,
                            textColor: appTheme.black_900,
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    controller.onTapLogin();
                                  },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: 90.h, bottom: 12.h),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    controller.onTapRegisterNow();
                  },
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
            ],
          ),
        ),
      ),
    );
  }
}
