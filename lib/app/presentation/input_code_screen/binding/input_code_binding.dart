import 'package:get/get.dart';
import 'package:laporin/app/presentation/input_code_screen/controller/input_code_controller.dart';

class InputCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputCodeController());
  }
}
