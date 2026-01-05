import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/main_screen/controller/main_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:laporin/app/presentation/laporan_screen/model/laporan_model.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart'; // Pastikan import snackbar

class LaporanController extends GetxController {
  final supabase = Supabase.instance.client;

  RxList<LaporanModel> laporanList = <LaporanModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLaporan();
  }

  Future<void> fetchLaporan() async {
    isLoading.value = true;
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      final response = await supabase
          .from('laporan')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      final List<dynamic> data = response;
      laporanList.value =
          data.map((json) => LaporanModel.fromJson(json)).toList();
    } catch (e) {
      print("Error fetch laporan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // --- FUNGSI HAPUS LAPORAN ---
  void deleteLaporan(String idLaporan, String imageUrl) {
    // 1. Ambil Warna Tema
    Color roleColor = Colors.blue;
    try {
      if (Get.isRegistered<MainController>()) {
        roleColor = Get.find<MainController>().themeColor;
      }
    } catch (e) {
      print("MainController belum di-init");
    }

    Get.defaultDialog(
      title: "Batalkan Laporan", // Judul diganti biar relevan
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      middleText:
          "Apakah Anda yakin ingin membatalkan laporan ini? Laporan akan ditandai sebagai dibatalkan.",
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      radius: 12,

      // Tombol Confirm (Merah)
      confirm: ElevatedButton(
        onPressed: () async {
          Get.back();
          await _processDelete(idLaporan, imageUrl);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        ),
        child: const Text("Batalkan"), // Ganti teks tombol
      ),

      // Tombol Batal Dialog
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: roleColor, width: 1.5),
          foregroundColor: roleColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        ),
        child: const Text("Kembali"),
      ),
    );
  }

  Future<void> _processDelete(String id, String imageUrl) async {
    try {
      // CATATAN: KITA TIDAK MENGHAPUS GAMBAR LAGI
      // Karena laporan ini masih ada (hanya statusnya batal), jadi bukti foto harus tetap disimpan.

      // 1. Update Status di Database menjadi 'dibatalkan'
      await supabase
          .from('laporan')
          .update({'status': 'dibatalkan'})
          .eq('id', id);

      // 2. Update List Lokal (Tanpa Reload API)
      // Cari item di list, lalu ganti statusnya secara manual biar UI langsung berubah
      int index = laporanList.indexWhere((item) => item.id == id);
      if (index != -1) {
        // Kita butuh refresh data, cara paling gampang fetch ulang atau replace object.
        // Agar simple dan konsisten, kita fetch ulang saja (karena logic Model.fromJson ada di sana)
        fetchLaporan();
      }

      CustomSnackBar.show(message: "Laporan berhasil dibatalkan");
    } catch (e) {
      CustomSnackBar.show(message: "Gagal membatalkan: $e", isError: true);
    }
  }

  // --- FUNGSI EDIT (NAVIGASI) ---
  void editLaporan(LaporanModel laporan) {
    // Validasi: Biasanya yang statusnya sudah diproses tidak boleh diedit
    if (laporan.statusIndex > 0) {
      CustomSnackBar.show(
        message: "Laporan yang sedang diproses tidak dapat diedit.",
        isError: true,
      );
      return;
    }

    // Navigasi ke Form dengan membawa data (Arguments)
    // Nanti di FormLaporanController kita tangkap arguments ini
    // Get.toNamed(Routes.FORM_LAPORAN, arguments: laporan);

    CustomSnackBar.show(
      message:
          "Info: Fitur Edit akan segera hadir (Logic Controller Form perlu disesuaikan",
      isError: true,
    );
  }
}
