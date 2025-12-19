import 'package:get/get.dart';

class DetailLaporanController extends GetxController {
  final String imageUrl =
      'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=1200';

  final String tanggal = '20 Oktober 2025';
  final String waktu = '1 Menit yang lalu';
  final String judul = 'Judul Laporan';

  final String deskripsi = '''
Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis.

Tempus leo eu aenean sed diam urna tempor. Pellentesque diam volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis.
''';

  void onBack() => Get.back();

  void onRespon() {
    // TODO: handle respon laporan
  }
}
