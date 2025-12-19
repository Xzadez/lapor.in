import 'package:get/get.dart';
import '../controller/pengurus_beranda_controller.dart';

class PengurusBerandaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengurusBerandaController>(() => PengurusBerandaController());
  }
}
