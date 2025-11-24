import 'package:get/get.dart';

class DetailLaporanController extends GetxController {
  var status = "DITOLAK".obs;
  var alasan = "Ditolak sudah ada laporan serupa".obs;

  var laporan = {
    "kategori": "Kategori",
    "urgensi": "Urgent",
    "judul": "Lampu jalan",
    "pengirim": "Nama Pengirim",
    "waktu": "1 Menit yang lalu",
    "deskripsi":
    "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat...",
    "gambar":
    "https:/images.unsplash.com/photo-1581094794329-c8112b3d1a43?fit=crop&w=600&q=80"
  }.obs;
}
