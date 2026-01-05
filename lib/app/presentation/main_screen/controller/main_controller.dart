import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/core/app_export.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainController extends GetxController {
  final supabase = Supabase.instance.client;

  var tabIndex = 0.obs;
  var currentRole = 'warga'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRole();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void fetchUserRole() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final data =
          await supabase
              .from('profiles')
              .select('role')
              .eq('id', user.id)
              .single();

      if (data != null && data['role'] != null) {
        currentRole.value = data['role'];
        print("Role User: ${currentRole.value}"); // Debug print
      }
    } catch (e) {
      print("Gagal ambil role: $e");
    }
  }

  // Getter Warna Dinamis
  Color get themeColor {
    // List role pengurus
    final List<String> pengurusRoles = ['ketua_rt', 'ketua_rw', 'admin'];

    // Obx akan mendeteksi perubahan pada `currentRole.value` di sini
    if (pengurusRoles.contains(currentRole.value)) {
      return const Color(0xFF35BBA4); // HIJAU TOSCA (Pengurus)
    } else {
      return const Color(0xFF1E88E5); // BIRU (Warga)
    }
  }

  void onTapAddReport() {
    // TODO: Navigasi ke halaman buat laporan baru
    Get.toNamed(AppRoutes.formLaporanScreen);

    CustomSnackBar.show(
      message: "Info: Fitur Tambah Laporan akan segera hadir!",
      isError: false,
    );
  }
}
