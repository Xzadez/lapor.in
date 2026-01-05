import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:laporin/app/presentation/laporan_screen/model/laporan_model.dart';

class RiwayatController extends GetxController {
  final supabase = Supabase.instance.client;

  RxList<LaporanModel> riwayatList = <LaporanModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRiwayat();
  }

  Future<void> fetchRiwayat() async {
    isLoading.value = true;
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      // PERBAIKAN: Gunakan .or() sebagai pengganti .in_()
      // Syntax string: 'kolom.operator.nilai, kolom.operator.nilai' (koma berarti OR)
      final response = await supabase
          .from('laporan')
          .select()
          .eq('user_id', user.id)
          .or('status.eq.selesai, status.eq.ditolak, status.eq.dibatalkan')
          .order('created_at', ascending: false);

      final List<dynamic> data = response;
      riwayatList.value =
          data.map((json) => LaporanModel.fromJson(json)).toList();
    } catch (e) {
      print("Error fetch riwayat: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
