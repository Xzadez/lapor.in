import 'package:get/get.dart';
import '../controller/controller.dart';

class TambahLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahLaporanController>(
          () => TambahLaporanController(),
    );
  }
}
