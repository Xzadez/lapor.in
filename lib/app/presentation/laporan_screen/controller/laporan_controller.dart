import 'package:get/get.dart';
import 'package:laporin/app/presentation/laporan_screen/model/laporan_model.dart';

class LaporanController extends GetxController {
  RxList<LaporanModel> laporanList = <LaporanModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Dummy data
    laporanList.value = [
      LaporanModel(
        tanggal: "20 Oktober 2025",
        judul: "Kabel Listrik",
        kategori: "Kategori",
        urgent: true,
        imageUrl: "https://picsum.photos/300/200?random=1",
        statusIndex: 1,
        estimasi: "Perkiraan 2 hari selesai",
      ),
      LaporanModel(
        tanggal: "20 Oktober 2025",
        judul: "Lampu jalan",
        kategori: "Kategori",
        urgent: true,
        imageUrl: "https://picsum.photos/300/200?random=2",
        statusIndex: 0,
        rejected: true,
      ),
    ];
  }
}
