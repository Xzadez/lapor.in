import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:laporin/app/presentation/laporan_screen/model/laporan_model.dart'; // Pakai Model Laporan yang sudah ada

class HomeController extends GetxController {
  final supabase = Supabase.instance.client;
  final currentPage = 0.obs;

  // List Laporan Terkini (Global/Umum)
  RxList<LaporanModel> laporanTerkini = <LaporanModel>[].obs;
  var isLoading = false.obs;

  // Slider Images (Tetap sama)
  final List<String> sliderImages = [
    'https://images.pexels.com/photos/460621/pexels-photo-460621.jpeg',
    'https://images.pexels.com/photos/1430677/pexels-photo-1430677.jpeg',
    'https://images.pexels.com/photos/1580285/pexels-photo-1580285.jpeg',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchLaporanTerkini();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  Future<void> fetchLaporanTerkini() async {
    isLoading.value = true;
    try {
      // AMBIL SEMUA LAPORAN (DARI SIAPA SAJA)
      // Syarat: Status = 'selesai'
      final response = await supabase
          .from('laporan')
          .select()
          .eq('status', 'selesai')
          .order('created_at', ascending: false) // Paling baru diatas
          .limit(5); // Ambil 5 saja biar tidak berat

      final List<dynamic> data = response;
      laporanTerkini.value =
          data.map((json) => LaporanModel.fromJson(json)).toList();
    } catch (e) {
      print("Error fetch laporan terkini: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
