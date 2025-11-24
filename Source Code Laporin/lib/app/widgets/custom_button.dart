import 'package:flutter/material.dart';
import 'package:laporin/app/core/utils/size.utils.dart';
import 'package:laporin/app/theme/text_style_helper.dart';

import '../core/app_export.dart';

/**
 * CustomButton - A reusable button component with configurable styling
 * 
 * @param text - The text to display on the button
 * @param onPressed - Callback function when button is pressed
 * @param backgroundColor - Background color of the button
 * @param textColor - Color of the button text
 * @param width - Width of the button (required)
 */
class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    required this.width,
  }) : super(key: key);

  /// Text to display on the button
  final String? text;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Background color of the button
  final Color? backgroundColor;

  /// Color of the button text
  final Color? textColor;

  /// Width of the button (required for proper layout)
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Color(0xFFD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.h),
          elevation: 0,
        ),
        child: Text(
          text ?? "Button",
          style: TextStyleHelper.instance.body14SemiBoldInter.copyWith(
            color: textColor ?? Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}
