import 'package:get/get.dart';
import '../model/riwayat_model.dart';

class RiwayatController extends GetxController {
  RxList<RiwayatModel> riwayatList = <RiwayatModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    riwayatList.value = [
      RiwayatModel(
        tanggal: "20 Oktober 2025",
        judul: "Kabel listrik",
        urgensi: "Urgent",
        kategori: "Kategori",
        gambar: "https://picsum.photos/300/200",
        status: "Proses",
      ),
      RiwayatModel(
        tanggal: "20 Oktober 2025",
        judul: "Lampu jalan",
        urgensi: "Urgent",
        kategori: "Kategori",
        gambar: "https://picsum.photos/300/201",
        status: "Ditolak",
      ),
    ];
  }
}
