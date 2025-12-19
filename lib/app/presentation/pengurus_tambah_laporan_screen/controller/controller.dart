import 'package:get/get.dart';

class TambahLaporanController extends GetxController {
  final nama = ''.obs;
  final deskripsi = ''.obs;
  final tanggal = DateTime.now().obs;
  final kategori = 'Fasilitas'.obs;
  final lampiran = ''.obs;

  final kategoriList = ['Lingkungan', 'Fasilitas', 'Kegiatan'];

  void setTanggal(DateTime value) {
    tanggal.value = value;
  }

  void simpan() {
    // TODO: submit ke API
  }

  void back() => Get.back();
}
