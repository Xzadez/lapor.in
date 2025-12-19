// File: app/routes/app_routes.dart
abstract class AppRoutes {
  // Menggunakan 'abstract class' agar tidak bisa diinstansiasi
  AppRoutes._();

  static const initialRoute = '/';
  static const SPLASH_SCREEN = '/splash_screen';
  static const mainScreen = '/main_screen';
  static const loginScreen = '/login_screen';
  static const registerScreen = '/register_screen';
  static const qrScanScreen = '/qr_scan_screen';
  static const selectedRoleScreen = '/selected_role_screen';
  static const jointMember = '/join_member_screen';
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
  static const pengurusBeranda = '/pengurus-beranda';
  static const pengurusLaporan = '/pengurus-laporan';
}
