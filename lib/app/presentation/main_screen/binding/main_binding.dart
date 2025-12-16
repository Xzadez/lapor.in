import 'package:get/get.dart';
import 'package:laporin/app/presentation/main_screen/controller/main_controller.dart';

// Import controller halaman lain agar lazy loaded
import 'package:laporin/app/presentation/home_screen/controller/home_controller.dart';
import 'package:laporin/app/presentation/laporan_screen/controller/laporan_controller.dart';
import 'package:laporin/app/presentation/riwayat_screen/controller/riwayat_controller.dart';
import 'package:laporin/app/presentation/profile_screen/controller/profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());

    // Inisialisasi controller child di sini agar tidak error saat pindah tab
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<LaporanController>(() => LaporanController());
    Get.lazyPut<RiwayatController>(() => RiwayatController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
