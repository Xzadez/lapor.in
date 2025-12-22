import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainController extends GetxController {
  var tabIndex = 0.obs;

  // Warna Default (Biru Warga)
  // Jika Admin/Pengurus akan berubah jadi Hijau Tosca (#35BBA4)
  var themeColor = const Color(0xFF1E88E5).obs;

  final supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
    _checkUserRole();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  Future<void> _checkUserRole() async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final data =
            await supabase
                .from('profiles')
                .select('role')
                .eq('id', user.id)
                .maybeSingle();

        if (data != null) {
          final role = data['role'] as String?;

          // Jika role adalah admin atau pengurus, ganti warna
          if (role == 'admin' || role == 'pengurus') {
            themeColor.value = const Color(0xFF35BBA4);
          } else {
            // Warga tetap warna default (Biru)
            themeColor.value = const Color(0xFF1E88E5);
          }
        }
      }
    } catch (e) {
      print("Error cek role: $e");
    }
  }
}
