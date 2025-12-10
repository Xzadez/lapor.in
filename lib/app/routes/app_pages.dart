// File: app/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:laporin/app/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:laporin/app/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:laporin/app/presentation/login_screen/binding/login_binding.dart';
import 'package:laporin/app/presentation/login_screen/login_screen.dart';
import 'package:laporin/app/presentation/lupa_password_screen/binding/lupa_password_binding.dart';
import 'package:laporin/app/presentation/lupa_password_screen/lupa_password_screen.dart';
import 'package:laporin/app/presentation/profile_screen/profile_screen.dart';
import 'package:laporin/app/presentation/profile_screen/binding/profile_binding.dart';
import 'package:laporin/app/presentation/detail_laporan_screen/detail_laporan_screen.dart';
import 'package:laporin/app/presentation/detail_laporan_screen/binding/detail_laporan_binding.dart';
import 'package:laporin/app/presentation/register_screen/bindings/register_binding.dart';
import 'package:laporin/app/presentation/register_screen/register_screen.dart';
import 'package:laporin/app/presentation/welcome_screen/welcome_screen.dart';
import 'package:laporin/app/presentation/welcome_screen/binding/welcome_binding.dart';
import 'package:laporin/app/presentation/home_screen/home_screen.dart';
import 'package:laporin/app/presentation/home_screen/binding/home_binding.dart';
import 'package:laporin/app/presentation/laporan_screen/laporan_screen.dart';
import 'package:laporin/app/presentation/laporan_screen/binding/laporan_binding.dart';
import 'package:laporin/app/presentation/riwayat_screen/riwayat_screen.dart';
import 'package:laporin/app/presentation/riwayat_screen/binding/riwayat_binding.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._(); // Private constructor

  // static const INITIAL = AppRoutes.initialRoute;
  static const INITIAL = AppRoutes.loginScreen;

  // Ubah nama dari 'pages' menjadi 'routes'
  static final routes = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: AppRoutes.registerScreen,
      page: () => RegisterScreen(),
      bindings: [RegisterBinding()],
    ),
    GetPage(
      name: AppRoutes.lupaPasswordScreen,
      page: () => const LupaPasswordScreen(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: AppRoutes.initialRoute,
      page: () => AppNavigationScreen(),
      bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.detailLaporanScreen,
      page: () => const DetailLaporanScreen(),
      binding: DetailLaporanBinding(),
    ),
    GetPage(
      name: AppRoutes.welcomeScreen,
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.laporanScreen,
      page: () => const LaporanScreen(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: AppRoutes.riwayatScreen,
      page: () => const RiwayatScreen(),
      binding: RiwayatBinding(),
    ),
  ];
}
