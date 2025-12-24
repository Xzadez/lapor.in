import 'package:get/get.dart';
import 'package:laporin/app/presentation/generate_code/controller/generate_code_controller.dart';

class GenerateCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateCodeController>(() => GenerateCodeController());
  }
}
