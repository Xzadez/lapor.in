import 'package:get/get.dart';
import '../controller/respon_laporan_controller.dart';

class ResponLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResponLaporanController>(
          () => ResponLaporanController(),
    );
  }
}
