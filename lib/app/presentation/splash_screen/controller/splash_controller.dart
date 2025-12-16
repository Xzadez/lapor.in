import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashController extends GetxController {
  final supabase = Supabase.instance.client;

  @override
  void onReady() {
    super.onReady();
    _checkAuthAndRole();
  }

  Future<void> _checkAuthAndRole() async {
    // 1. (Opsional) Beri sedikit delay agar logo package kamu sempat terlihat
    // atau untuk transisi yang lebih halus.
    await Future.delayed(const Duration(seconds: 2));

    final session = supabase.auth.currentSession;

    // 2. CEK LOGIN: Apakah ada sesi aktif?
    if (session == null) {
      // Jika tidak login, lempar ke Login
      Get.offAllNamed(AppRoutes.loginScreen);
      return;
    }

    try {
      // 3. CEK ROLE: Ambil data profile dari Supabase
      final userId = session.user.id;

      // Ambil kolom 'role' dari tabel 'profiles'
      final data =
          await supabase
              .from('profiles')
              .select('role')
              .eq('id', userId)
              .maybeSingle(); // Gunakan maybeSingle agar aman jika data null

      // 4. NAVIGASI BERDASARKAN ROLE
      if (data == null ||
          data['role'] == null ||
          data['role'].toString().isEmpty) {
        // KASUS: Sudah Login, TAPI Belum Pilih Role -> Ke Halaman Pilih Role
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        // KASUS: Sudah Login DAN Sudah Punya Role -> Ke Main Screen (Home)
        Get.offAllNamed(AppRoutes.mainScreen);
      }
    } catch (e) {
      print("Error Check Role: $e");
      // Jika terjadi error (misal koneksi putus saat cek role),
      // Aman-nya lempar ke Login agar user mencoba ulang
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }
}
