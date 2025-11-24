// File: app/routes/app_routes.dart
abstract class AppRoutes {
  // Menggunakan 'abstract class' agar tidak bisa diinstansiasi
  AppRoutes._();

  static const loginScreen = '/login_screen';
  static const appNavigationScreen = '/app_navigation_screen';
  static const initialRoute = '/';
}
