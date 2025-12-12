import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/theme/theme_helper.dart';

class CustomSnackBar {
  static void show({required String message, bool isError = false}) {
    if (Get.context == null) return;

    final backgroundColor = isError ? appTheme.redCustom : appTheme.greenCustom;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    final screenHeight = Get.height;

    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(
          bottom: screenHeight - 160,
          left: 20,
          right: 20,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
