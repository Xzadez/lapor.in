// File: app/routes/app_routes.dart
abstract class AppRoutes {
  // Menggunakan 'abstract class' agar tidak bisa diinstansiasi
  AppRoutes._();

  static const initialRoute = '/';
  static const loginScreen = '/login_screen';
  static const registerScreen = '/register_screen';
  static const lupaPasswordScreen = '/lupa_password_screen';
  static const otpScreen = '/otp_screen';
  static const resetPasswordScreen = '/reset_password_screen';
  static const appNavigationScreen = '/app_navigation_screen';
  static const profileScreen = '/profile_screen';
  static const detailLaporanScreen = '/detail_laporan_screen';
  static const welcomeScreen = '/welcome_screen';
  static const homeScreen = '/home_screen';
  static const laporanScreen = '/laporan_screen';
  static const riwayatScreen = '/riwayat_screen';
  static const formLaporanScreen = '/form_laporan_screen';
}