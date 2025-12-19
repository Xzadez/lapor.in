import 'package:get/get.dart';
import '../controller/pengurus_laporan_controller.dart';

class LaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanController>(() => LaporanController());
  }
}
