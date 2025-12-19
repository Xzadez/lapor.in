import 'package:get/get.dart';

enum LaporanProgress {
  diajukan,
  diterima,
  diproses,
  selesai,
}

class ResponLaporanController extends GetxController {
  final Rx<LaporanProgress> progress =
      LaporanProgress.diajukan.obs;

  void setProgress(LaporanProgress value) {
    progress.value = value;
  }

  int get progressIndex => LaporanProgress.values.indexOf(progress.value);
}
