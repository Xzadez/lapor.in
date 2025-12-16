// FILE: lib/main.dart
import 'package:flutter/material.dart';

// Import semua halaman yang sudah dibuat tim
import 'features/onboarding/welcome/views/welcome_screen.dart';
import 'features/auth/login/views/login_page.dart';
import 'features/auth/forgot_password/views/forgot_password_page.dart';
import 'features/home/views/home_screen.dart';
import 'features/profile/views/profile_page.dart';
import 'features/report/create_report/views/laporan_screen.dart';
import 'features/report/history/views/riwayat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Laporin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Tentukan halaman pertama yang muncul
      initialRoute: '/', 
      
      // SISTEM NAVIGASI (ROUTING)
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfilePage(),
        '/create-report': (context) => LaporanScreen(),
        '/history': (context) => RiwayatScreen(),
      },
    );
  }
}
