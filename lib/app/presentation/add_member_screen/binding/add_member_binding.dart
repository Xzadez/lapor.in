import 'package:get/get.dart';
import 'package:laporin/app/presentation/add_member_screen/controller/add_member_controller.dart';

class AddMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMemberController>(() => AddMemberController());
  }
}
