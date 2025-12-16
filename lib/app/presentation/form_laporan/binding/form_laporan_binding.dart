import 'package:get/get.dart';
import 'package:laporin/app/presentation/form_laporan/controller/form_laporan_controller.dart';

class FormLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormLaporanController>(
      () => FormLaporanController(),
    );
  }
}
