import 'package:get/get.dart';
import 'app_routes.dart';

// Imports Screens
import '../presentation/login_screen/login_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

// Imports Bindings
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';

class AppPages {
  // Tentukan rute awal aplikasi (biasanya diambil dari AppRoutes)
  static const INITIAL = AppRoutes.initialRoute;

  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding()
      ],
    ),
    GetPage(
      name: AppRoutes.appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding()
      ],
    ),
    GetPage(
      name: AppRoutes.initialRoute,
      page: () => AppNavigationScreen(),
      bindings: [
        AppNavigationBinding()
      ],
    ),
  ];
}
