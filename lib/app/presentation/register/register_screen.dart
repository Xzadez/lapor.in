import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/core/utils/image_constant.dart';
import 'package:laporin/app/core/utils/size.utils.dart';
import 'package:laporin/app/theme/text_style_helper.dart';
import 'package:laporin/app/theme/theme_helper.dart';

import 'package:laporin/app/presentation/register/controllers/register_controller.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';

class RegisterScreen extends GetWidget<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Set true jika ingin konten naik saat keyboard muncul
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
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 50.h, left: 32.h, right: 32.h),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildHeaderLogo(),
                        SizedBox(height: 30.h),

                        // First Name & Last Name
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                controller: controller.firstNameController,
                                placeholder: 'First Name',
                                inputType: TextInputType.name,
                                borderColor: appTheme.white_A700,
                                backgroundColor: appTheme.color47D9D9,
                                textColor: appTheme.white_A700,
                                validator:
                                    (value) => controller.validateRequired(
                                      value,
                                      'First Name',
                                    ),
                              ),
                            ),
                            SizedBox(width: 12.h),
                            Expanded(
                              child: CustomTextFormField(
                                controller: controller.lastNameController,
                                placeholder: 'Last Name',
                                inputType: TextInputType.name,
                                borderColor: appTheme.white_A700,
                                backgroundColor: appTheme.color47D9D9,
                                textColor: appTheme.white_A700,
                                validator:
                                    (value) => controller.validateRequired(
                                      value,
                                      'Last Name',
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        // Birth Day (Read Only + Tap Action)
                        GestureDetector(
                          onTap: () => controller.selectDate(context),
                          child: AbsorbPointer(
                            child: CustomTextFormField(
                              controller: controller.birthDayController,
                              placeholder: 'Birth Day (DD/MM/YYYY)',
                              inputType: TextInputType.datetime,
                              borderColor: appTheme.white_A700,
                              backgroundColor: appTheme.color47D9D9,
                              textColor: appTheme.white_A700,
                              suffixIconPath:
                                  ImageConstant
                                      .imgPlaceholder, // Ganti icon calendar jika ada
                              validator:
                                  (value) => controller.validateRequired(
                                    value,
                                    'Birth Day',
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Username
                        CustomTextFormField(
                          controller: controller.usernameController,
                          placeholder: 'Username',
                          inputType: TextInputType.text,
                          borderColor: appTheme.white_A700,
                          backgroundColor: appTheme.color47D9D9,
                          textColor: appTheme.white_A700,
                          validator:
                              (value) => controller.validateRequired(
                                value,
                                'Username',
                              ),
                        ),
                        SizedBox(height: 12.h),

                        // Email
                        CustomTextFormField(
                          controller: controller.emailController,
                          placeholder: 'Email Address',
                          inputType: TextInputType.emailAddress,
                          borderColor: appTheme.white_A700,
                          backgroundColor: appTheme.color47D9D9,
                          textColor: appTheme.white_A700,
                          validator: (value) => controller.validateEmail(value),
                        ),
                        SizedBox(height: 12.h),

                        // Password
                        CustomTextFormField(
                          controller: controller.passwordController,
                          placeholder: 'Password',
                          inputType: TextInputType.visiblePassword,
                          isPasswordField: true,
                          suffixIconPath: ImageConstant.imgGroup15,
                          borderColor: appTheme.white_A700,
                          backgroundColor: appTheme.color47D9D9,
                          textColor: appTheme.white_A700,
                          validator:
                              (value) => controller.validatePassword(value),
                        ),
                        SizedBox(height: 12.h),

                        // Repeat Password
                        CustomTextFormField(
                          controller: controller.repeatPasswordController,
                          placeholder: 'Repeat Password',
                          inputType: TextInputType.visiblePassword,
                          isPasswordField: true,
                          suffixIconPath: ImageConstant.imgGroup15,
                          borderColor: appTheme.white_A700,
                          backgroundColor: appTheme.color47D9D9,
                          textColor: appTheme.white_A700,
                          validator:
                              (value) =>
                                  controller.validateRepeatPassword(value),
                        ),

                        SizedBox(height: 40.h),

                        // Button Register
                        Obx(() {
                          return CustomButton(
                            text:
                                controller.isLoading.value
                                    ? 'Loading...'
                                    : 'Register',
                            width: double.infinity,
                            backgroundColor: appTheme.blue_gray_100,
                            textColor: appTheme.black_900,
                            onPressed:
                                controller.isLoading.value
                                    ? null
                                    : () => controller.onTapRegister(),
                          );
                        }),
                        SizedBox(
                          height: 40.h,
                        ), // Spacer bawah agar scroll bisa lebih leluasa
                      ],
                    ),
                  ),
                ),
              ),
              // Footer Login
              _buildFooterLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderLogo() {
    return Column(
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgTowers,
          height: 44.h,
          width: 44.h,
        ),
        SizedBox(height: 18.h),
        Text(
          'Daftar Akun Baru',
          style: TextStyleHelper.instance.title20ExtraBoldInter.copyWith(
            height: 1.25,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Lengkapi data diri anda',
          style: TextStyleHelper.instance.label11RegularInter.copyWith(
            color: appTheme.white_A700,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLogin() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 32.h, bottom: 20.h, top: 10.h),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          controller.onTapLogin();
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Sudah punya akun? ',
                style: TextStyleHelper.instance.body14RegularInter.copyWith(
                  height: 1.21,
                ),
              ),
              TextSpan(
                text: 'Login disini',
                style: TextStyleHelper.instance.body14BoldInter.copyWith(
                  height: 1.21,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
