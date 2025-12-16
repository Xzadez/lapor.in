import 'package:get/get.dart';

class FormLaporanController extends GetxController {
  final namaPelaporController = ''.obs;
  final deskripsiLaporanController = ''.obs;
  final tanggalController = ''.obs;
  final selectedKategori = 'Fasilitas'.obs;
  final lampiranFotoController = ''.obs;

  void saveLaporan() {
    // Implement save logic here
    print('Nama Pelapor: ${namaPelaporController.value}');
    print('Deskripsi Laporan: ${deskripsiLaporanController.value}');
    print('Tanggal: ${tanggalController.value}');
    print('Kategori: ${selectedKategori.value}');
    print('Lampiran Foto: ${lampiranFotoController.value}');
  }
}