import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/profile/view/profile_page.dart';
import 'app/core/theme/app_theme.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Module',
      theme: AppTheme.lightTheme,
      home: const ProfilePage(),
    );
  }
}
