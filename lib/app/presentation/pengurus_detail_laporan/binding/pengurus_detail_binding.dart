import 'package:get/get.dart';
import '../controller/pengurus_detail_controller.dart';

class DetailLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailLaporanController>(
          () => DetailLaporanController(),
    );
  }
}
