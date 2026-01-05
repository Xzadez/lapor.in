import 'package:get/get.dart';
import 'package:laporin/app/presentation/laporan_screen/model/laporan_model.dart';

class DetailLaporanController extends GetxController {
  var laporanData = <String, dynamic>{}.obs;
  var statusLabel = "".obs;
  var statusDesc = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is LaporanModel) {
      LaporanModel data = Get.arguments;
      _mapDataToView(data);
    }
  }

  void _mapDataToView(LaporanModel data) {
    // 1. Label Status
    String status = "MENUNGGU";
    if (data.cancelled)
      status = "DIBATALKAN";
    else if (data.rejected)
      status = "DITOLAK";
    else if (data.statusIndex == 2)
      status = "DITERIMA";
    else if (data.statusIndex == 3)
      status = "DIPROSES";
    else if (data.statusIndex == 4)
      status = "SELESAI";

    statusLabel.value = status;

    // 2. Alasan/Pesan
    if (data.estimasi != null && data.estimasi!.isNotEmpty) {
      statusDesc.value = data.estimasi!;
    } else {
      if (status == "MENUNGGU")
        statusDesc.value = "Laporan sedang ditinjau oleh petugas.";
      else if (status == "DITOLAK")
        statusDesc.value = "Laporan tidak memenuhi kriteria.";
      else if (status == "SELESAI")
        statusDesc.value = "Laporan telah ditangani.";
      else
        statusDesc.value = "Sedang dalam pengerjaan.";
    }

    // 3. Masukkan ke Map UI
    laporanData.value = {
      "judul": data.judul, // Judul tetap singkat (di header detail)
      "kategori": data.kategori,
      "urgensi": data.urgent ? "Urgent" : "Normal",
      "pengirim": "Saya",
      "waktu": data.tanggal,

      // PERBAIKAN DI SINI:
      "deskripsi": data.deskripsi, // Gunakan deskripsi FULL, bukan judul

      "gambar": data.imageUrl,
    };
  }
}
