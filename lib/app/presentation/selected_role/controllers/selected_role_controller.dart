import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';

class SelectedRoleController extends GetxController {
  // 1. Logic Tombol GABUNG (User ingin jadi Warga di RT/RW yang sudah ada)
  void onJoinMember() {
    // Idealnya: Pindah ke halaman input Kode Undangan / Scan QR
    // Contoh: Get.toNamed(AppRoutes.joinInstanceScreen);

    print("User memilih: Gabung Instansi");
    Get.toNamed(AppRoutes.jointMember);

    // SEMENTARA: Kita bisa arahkan ke Home dulu untuk testing
    // Get.offAllNamed(AppRoutes.mainScreen);
  }

  // 2. Logic Tombol BUAT (User ingin jadi Ketua RT/RW baru)
  void onCreateCommunity() {
    // Idealnya: Pindah ke halaman Form Pendaftaran Instansi Baru
    // Contoh: Get.toNamed(AppRoutes.createInstanceScreen);

    print("User memilih: Buat Komunitas Baru");
    Get.toNamed(AppRoutes.createMember);
  }

  // 3. Logic LEWATI (Opsional)
  void onSkip() {
    // Bisa diarahkan ke Home sebagai 'Guest' atau tetap memaksa pilih role.
    // Jika aplikasi mewajibkan role, tombol skip sebaiknya dihapus.
    Get.offAllNamed(AppRoutes.mainScreen);
  }
}
