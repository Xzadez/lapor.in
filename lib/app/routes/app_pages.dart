// File: app/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:laporin/app/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:laporin/app/presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import 'package:laporin/app/presentation/login_screen/binding/login_binding.dart';
import 'package:laporin/app/presentation/login_screen/login_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._(); // Private constructor

  static const INITIAL = AppRoutes.initialRoute;

  // Ubah nama dari 'pages' menjadi 'routes'
  static final routes = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
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
  ];
}
