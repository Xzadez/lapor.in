import 'package:get/get.dart';
import '../controller/laporan_controller.dart';

class LaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanController>(() => LaporanController());
  }
}
