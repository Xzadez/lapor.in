import 'package:get/get.dart';
import 'package:laporin/app/presentation/manage_member_screen/controller/manage_member_controller.dart';

class ManageMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageMemberController>(() => ManageMemberController());
  }
}
