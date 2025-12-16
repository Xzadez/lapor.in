import 'package:get/get.dart';

class DetailLaporanController extends GetxController {
  // Observable variables
  var status = "DITOLAK".obs;
  var alasan = "Ditolak sudah ada laporan serupa".obs;

  var laporan =
      {
        "kategori": "Kategori",
        "urgensi": "Urgent",
        "judul": "Lampu jalan",
        "pengirim": "Nama Pengirim",
        "waktu": "1 Menit yang lalu",
        // Menggunakan teks panjang sesuai gambar
        "deskripsi":
            "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.\n\nLorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.",
        "gambar":
            "https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=800&q=80", // Gambar kantor/kerja
      }.obs;
}
