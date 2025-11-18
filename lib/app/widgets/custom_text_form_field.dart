import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/**
 * A customizable text form field component that supports email and password input types
 * with configurable styling, validation, and suffix icons.
 * 
 * @param placeholder - The hint text displayed in the input field
 * @param inputType - The type of keyboard and input validation (email, password, etc.)
 * @param isPasswordField - Whether this is a password input field with obscured text
 * @param suffixIconPath - Path to the suffix icon image (typically for password visibility toggle)
 * @param borderColor - Color of the input field border
 * @param backgroundColor - Background fill color of the input field
 * @param textColor - Color of the input text
 * @param validator - Validation function for form validation
 * @param controller - Text editing controller for the input field
 * @param margin - External spacing around the input field
 * @param onSuffixIconTap - Callback function when suffix icon is tapped
 */
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    this.placeholder,
    this.inputType = TextInputType.text,
    this.isPasswordField = false,
    this.suffixIconPath,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.validator,
    this.controller,
    this.margin,
    this.onSuffixIconTap,
  }) : super(key: key);

  /// Placeholder text shown in the input field
  final String? placeholder;

  /// Keyboard type for the input field
  final TextInputType inputType;

  /// Whether this is a password field with obscured text
  final bool isPasswordField;

  /// Path to the suffix icon (typically for password visibility)
  final String? suffixIconPath;

  /// Border color of the input field
  final Color? borderColor;

  /// Background color of the input field
  final Color? backgroundColor;

  /// Text color of the input
  final Color? textColor;

  /// Validation function for form validation
  final String? Function(String?)? validator;

  /// Text editing controller
  final TextEditingController? controller;

  /// External margin around the input field
  final EdgeInsets? margin;

  /// Callback when suffix icon is tapped
  final VoidCallback? onSuffixIconTap;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPasswordField;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
    if (widget.onSuffixIconTap != null) {
      widget.onSuffixIconTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.isPasswordField ? _isObscured : false,
        validator: widget.validator,
        style: TextStyleHelper.instance.label11RegularInter.copyWith(
            color: widget.textColor ?? Color(0xFFFFFFFF), height: (14 / 11)),
        decoration: InputDecoration(
          hintText: widget.placeholder ?? '',
          hintStyle: TextStyleHelper.instance.label11RegularInter.copyWith(
              color: widget.textColor ?? Color(0xFFFFFFFF), height: (14 / 11)),
          filled: true,
          fillColor: widget.backgroundColor ?? Color(0x47D9D9D9),
          contentPadding: EdgeInsets.only(
            top: widget.isPasswordField ? 12.h : 14.h,
            right: widget.isPasswordField ? 40.h : 16.h,
            bottom: widget.isPasswordField ? 12.h : 14.h,
            left: 16.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(
              color: widget.borderColor ?? Color(0xFFFFFFFF),
              width: 1.h,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(
              color: widget.borderColor ?? Color(0xFFFFFFFF),
              width: 1.h,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(
              color: widget.borderColor ?? Color(0xFFFFFFFF),
              width: 1.h,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(
              color: appTheme.red_A700,
              width: 1.h,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(
              color: appTheme.red_A700,
              width: 1.h,
            ),
          ),
          suffixIcon: widget.suffixIconPath != null
              ? GestureDetector(
                  onTap: widget.isPasswordField
                      ? _togglePasswordVisibility
                      : widget.onSuffixIconTap,
                  child: Container(
                    padding: EdgeInsets.all(12.h),
                    child: CustomImageView(
                      imagePath: widget.suffixIconPath!,
                      height: 20.h,
                      width: 24.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
